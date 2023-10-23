require "uri"
require "http"

module HAR
  # This object contains detailed info about performed request.
  #
  # The total request size sent can be computed as follows
  # (if both values are available):
  #
  # ```
  # total_size = entry.request.headers_size + entry.request.body_size
  # ```
  class Request
    include JSON::Serializable

    FORMDATA_MIME_VALUES = {"application/x-www-form-urlencoded", "multipart/form-data"}

    Log = ::Log.for(self)

    # Request method (`GET`, `POST`, ...).
    property method : String

    # Absolute URL of the request (fragments are not included).
    property url : String

    # Request HTTP Version.
    @[JSON::Field(key: "httpVersion")]
    property http_version : String

    # List of cookie objects.
    property cookies : Array(Cookie)

    # List of header objects.
    property headers : Array(Header)

    # List of query parameter objects.
    @[JSON::Field(key: "queryString")]
    property query_string : Array(QueryString)

    # Posted data info.
    @[JSON::Field(key: "postData")]
    property post_data : PostData?

    # Total number of bytes from the start of the HTTP request message until
    # (and including) the double `CRLF` before the body.
    # NOTE: Set to `-1` if the info is not available.
    @[JSON::Field(key: "headersSize")]
    property headers_size : Int32?

    # Size of the request body (`POST` data payload) in bytes.
    # NOTE: Set to `-1` if the info is not available.
    @[JSON::Field(key: "bodySize")]
    property body_size : Int32?

    # A comment provided by the user or the application.
    property comment : String?

    def self.new(http_request : HTTP::Request)
      request = Request.new(
        method: http_request.method,
        url: http_request.resource,
        http_version: http_request.version,
        post_data: PostData.new(text: http_request.body.try &.gets_to_end)
      )
      request.http_cookies = http_request.cookies
      request.http_headers = http_request.headers
      request
    end

    def initialize(
      @method,
      @url,
      @http_version,
      @cookies = Array(Cookie).new,
      @headers = Array(Header).new,
      @query_string = Array(QueryString).new,
      @post_data = nil,
      @headers_size = nil,
      @body_size = nil,
      @comment = nil
    )
    end

    def uri : URI
      URI.parse(url)
    end

    def body : String?
      return unless post_data = @post_data

      text = post_data.text.presence
      return text if text

      if post_data.mime_type.try &.in?(FORMDATA_MIME_VALUES)
        http_params = post_data.http_params
        http_params.to_s unless http_params.empty?
      end
    end

    def http_headers : HTTP::Headers
      HTTP::Headers.new.tap do |http_headers|
        headers.each do |header|
          http_headers.add(header.name, header.value)
        end
      end
    end

    def http_headers=(http_headers : HTTP::Headers)
      headers.clear
      http_headers.each do |key, values|
        headers << Header.new(name: key, value: values.join ", ")
      end
    end

    def http_cookies : HTTP::Cookies
      HTTP::Cookies.new.tap do |http_cookies|
        cookies.each do |cookie|
          http_cookies << cookie.to_http_cookie
        end
      end
    end

    def http_cookies=(http_cookies : HTTP::Cookies)
      cookies.clear
      http_cookies.each do |http_cookie|
        cookies << Cookie.new(http_cookie)
      end
    end

    def query_string_http_params : URI::Params
      URI::Params.new.tap do |http_params|
        query_string.each do |param|
          http_params[param.name] = param.value
        end
      end
    end

    def to_http_request : HTTP::Request
      request = HTTP::Request.new(
        method: method,
        resource: url,
        headers: http_headers,
        body: body,
        version: http_version
      )
      cookies.each do |cookie|
        request.cookies << cookie.to_http_cookie
      rescue ex
        Log.warn(exception: ex) { "Invalid cookie: #{cookie.inspect}" }
      end
      request
    end
  end
end

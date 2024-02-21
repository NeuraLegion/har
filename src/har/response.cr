require "base64"
require "mime/media_type"
require "http"

module HAR
  # This object contains detailed info about the response.
  #
  # The total response size received can be computed as follows
  # (if both values are available):
  #
  # ```
  # total_size = entry.response.headers_size + entry.response.body_size
  # ```
  class Response
    include JSON::Serializable

    # Response status code.
    property status : Int32

    # Response status description.
    @[JSON::Field(key: "statusText")]
    property status_text : String

    # Response HTTP Version.
    @[JSON::Field(key: "httpVersion")]
    property http_version : String

    # List of cookie objects.
    property cookies : Array(Cookie)

    # List of header objects.
    property headers : Array(Header)

    # Details about the response body.
    property content : Content

    # Redirection target URL from the Location response header.
    @[JSON::Field(key: "redirectURL")]
    property redirect_url : String?

    # Total number of bytes from the start of the HTTP response message until
    # (and including) the double `CRLF` before the body.
    #
    # NOTE: Set to `-1` if the info is not available.
    # NOTE: The size of received response-headers is computed only from headers
    #       that are really received from the server. Additional headers appended by
    #       the browser are not included in this number, but they appear in the list
    #       of header objects.
    @[JSON::Field(key: "headersSize")]
    property headers_size : Int32?

    # Size of the received response body in bytes.
    # Set to `0` in case of responses coming from the cache (`304`).
    # NOTE: Set to `-1` if the info is not available.
    @[JSON::Field(key: "bodySize")]
    property body_size : Int32?

    # A comment provided by the user or the application.
    property comment : String?

    def self.new(http_response : HTTP::Client::Response)
      response = Response.new(
        status: http_response.status_code,
        status_text: http_response.status_message.to_s,
        http_version: http_response.version,
        content: Content.new(
          text: http_response.body.to_s,
          mime_type: http_response.content_type
        )
      )
      response.http_cookies = http_response.cookies
      response.http_headers = http_response.headers
      response
    end

    def initialize(
      @status,
      @status_text,
      @http_version,
      @content,
      @redirect_url = nil,
      @cookies = Array(Cookie).new,
      @headers = Array(Header).new,
      @headers_size = nil,
      @body_size = nil,
      @comment = nil
    )
    end

    def mime_type : MIME::MediaType?
      mime_type = content.mime_type || http_headers["Content-Type"]?
      if mime_type = mime_type.presence
        MIME::MediaType.parse(mime_type)
      end
    end

    def content_type : String?
      mime_type.try &.media_type
    end

    def body : String?
      return unless text = content.text

      case content.encoding.try(&.downcase)
      when "base64"
        Base64.decode_string(text)
      else
        text
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
        values.each do |value|
          headers << Header.new(name: key, value: value)
        end
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

    def to_http_response : HTTP::Client::Response
      response = HTTP::Client::Response.new(
        status_code: status,
        status_message: status_text,
        body: body,
        headers: http_headers,
        version: http_version
      )
      cookies.each do |cookie|
        response.cookies << cookie.to_http_cookie
      end
      response.cookies.add_response_headers(response.headers)
      response
    end
  end
end

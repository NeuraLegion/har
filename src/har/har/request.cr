require "uri"
require "http"

module HAR
  class Request
    include JSON::Serializable

    property method : String
    property url : String
    @[JSON::Field(key: "httpVersion")]
    property http_version : String
    property cookies : Array(Cookie)
    property headers : Array(Header)
    @[JSON::Field(key: "queryString")]
    property query_string : Array(QueryString)
    @[JSON::Field(key: "postData")]
    property post_data : PostData?
    @[JSON::Field(key: "headersSize")]
    property headers_size : Int32?
    @[JSON::Field(key: "bodySize")]
    property body_size : Int32?
    property comment : String?

    def self.new(http_request : HTTP::Request)
      request = Request.new(
        method: http_request.method,
        url: http_request.resource,
        http_version: http_request.version
      )
      request.http_cookies = http_request.cookies
      request.http_headers = http_request.headers
      request.post_data = PostData.new(text: http_request.body.to_s)
      request
    end

    def initialize(@method, @url, @http_version, @headers_size = nil, @body_size = nil)
      @cookies = Array(Cookie).new
      @headers = Array(Header).new
      @query_string = Array(QueryString).new
    end

    def uri : URI
      URI.parse(url)
    end

    def body : String?
      return unless post_data = @post_data

      text = post_data.text
      return text if text && !text.empty?

      if post_data.mime_type.try &.["application/x-www-form-urlencoded"]?
        http_params = post_data.http_params
        http_params.to_s unless http_params.empty?
      end
    end

    def http_headers : HTTP::Headers
      HTTP::Headers.new.tap do |http_headers|
        headers.each do |header|
          http_headers[header.name] = header.value
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

    def query_string_http_params : HTTP::Params
      HTTP::Params.new.tap do |http_params|
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
      end
      request
    end
  end
end

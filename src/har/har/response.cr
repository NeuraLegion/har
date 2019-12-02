require "base64"
require "mime/media_type"
require "http"

module HAR
  class Response
    include JSON::Serializable

    property status : Int32
    @[JSON::Field(key: "statusText")]
    property status_text : String
    @[JSON::Field(key: "httpVersion")]
    property http_version : String
    property cookies : Array(Cookie)
    property headers : Array(Header)
    property content : Content
    @[JSON::Field(key: "redirectURL")]
    property redirect_url : String?
    @[JSON::Field(key: "headersSize")]
    property headers_size : Int32?
    @[JSON::Field(key: "bodySize")]
    property body_size : Int32?
    property comment : String?

    def self.new(http_response : HTTP::Client::Response)
      content = Content.new(text: http_response.body.to_s)
      content.mime_type = http_response.content_type
      response = Response.new(
        status: http_response.status_code,
        status_text: http_response.status_message.to_s,
        http_version: http_response.version,
        content: content
      )
      response.http_cookies = http_response.cookies
      response.http_headers = http_response.headers
      response
    end

    def initialize(
      @status, @status_text,
      @http_version,
      @content,
      @redirect_url = nil,
      @headers_size = nil,
      @body_size = nil
    )
      @cookies = Array(Cookie).new
      @headers = Array(Header).new
    end

    def mime_type : MIME::MediaType?
      mime_type = content.mime_type || http_headers["Content-Type"]?
      if mime_type && !mime_type.empty?
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
      response
    end
  end
end

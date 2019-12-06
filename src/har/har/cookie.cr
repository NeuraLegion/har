require "http"

module HAR
  class Cookie
    include JSON::Serializable

    # The name of the cookie.
    property name : String

    # The cookie value.
    property value : String

    # The path pertaining to the cookie.
    property path : String?

    # The host of the cookie.
    property domain : String?

    # Cookie expiration time (ISO 8601 - `YYYY-MM-DDThh:mm:ss.sTZD`,
    # e.g. `2009-07-24T19:20:30.123+02:00`).
    property expires : String?

    # `true` if the cookie is HTTP only, `false` otherwise.
    @[JSON::Field(key: "httpOnly")]
    property http_only : Bool?

    # `true` if the cookie was transmitted over ssl, `false` otherwise.
    property secure : Bool?

    # A comment provided by the user or the application.
    property comment : String?

    def self.new(http_cookie : HTTP::Cookie)
      Cookie.new(name: http_cookie.name, value: http_cookie.value).tap do |cookie|
        cookie.path = http_cookie.path
        cookie.domain = http_cookie.domain
        cookie.expires = http_cookie.expires.try &->Time::Format::RFC_3339.format(Time)
        cookie.http_only = http_cookie.http_only
        cookie.secure = http_cookie.secure
      end
    end

    def initialize(
      @name,
      @value,
      @path = nil,
      @domain = nil,
      @expires = nil,
      @http_only = nil,
      @secure = nil,
      @comment = nil
    )
    end

    def expires_at : Time?
      expires.try { |time| Time.parse_rfc3339(time) }
    end

    def http_only? : Bool
      !!http_only
    end

    def secure? : Bool
      !!secure
    end

    def to_http_cookie : HTTP::Cookie
      HTTP::Cookie.new(
        name: name,
        value: value,
        path: path || "/",
        domain: domain,
        expires: expires_at,
        http_only: http_only?,
        secure: secure?,
      )
    end
  end
end

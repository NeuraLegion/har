require "http"

module HAR
  class Cookie
    include JSON::Serializable

    property name : String
    property value : String
    property path : String?
    property domain : String?
    property expires : String | Hash(String, String)?
    @[JSON::Field(key: "httpOnly")]
    property http_only : Bool?
    property secure : Bool?
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

    def initialize(@name, @value)
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

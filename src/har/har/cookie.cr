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

    def initialize(@name, @value)
    end
  end
end

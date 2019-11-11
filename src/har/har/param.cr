module HAR
  class Param
    include JSON::Serializable

    property name : String
    property value : String?
    @[JSON::Field(key: "fileName")]
    property file_name : String?
    @[JSON::Field(key: "contentType")]
    property content_type : String?
    property comment : String?

    def initialize(@name, @value = nil)
    end
  end
end

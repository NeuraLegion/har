module HAR
  class Param
    include JSON::Serializable

    # Name of a posted parameter.
    property name : String

    # Value of a posted parameter or content of a posted file.
    property value : String?

    # Name of a posted file.
    @[JSON::Field(key: "fileName")]
    property file_name : String?

    # Content type of a posted file.
    @[JSON::Field(key: "contentType")]
    property content_type : String?

    # A comment provided by the user or the application.
    property comment : String?

    def initialize(
      @name,
      @value = nil,
      @file_name = nil,
      @content_type = nil,
      @comment = nil
    )
    end
  end
end

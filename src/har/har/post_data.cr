module HAR
  class PostData
    include JSON::Serializable

    @[JSON::Field(key: "mimeType")]
    property mime_type : String?
    property params : Array(Param)?
    property text : String?
    property comment : String?

    def initialize(@text)
    end
  end
end

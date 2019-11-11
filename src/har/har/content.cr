module HAR
  class Content
    include JSON::Serializable

    property size : Int32?
    property compression : Int32?
    @[JSON::Field(key: "mimeType")]
    property mime_type : String?
    property text : String?
    property encoding : String?
    property comment : String?

    def initialize(@text)
      @size = @text.to_s.size
    end
  end
end

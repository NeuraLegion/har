module HAR
  class PageTimings
    include JSON::Serializable

    @[JSON::Field(key: "onContentLoad")]
    property on_content_load : Int32 | Float32 | Float64?
    @[JSON::Field(key: "onLoad")]
    property on_load : Int32 | Float32 | Float64?
    property comment : String?
  end
end

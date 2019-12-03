module HAR
  class CacheRequest
    include JSON::Serializable

    property expires : String?
    @[JSON::Field(key: "lastAccess")]
    property last_access : String?
    @[JSON::Field(key: "eTag")]
    property etag : String?
    @[JSON::Field(key: "hitCount")]
    property hit_count : Int32?
    property comment : String?

    def initialize(@last_access, @etag, @hit_count)
    end
  end
end

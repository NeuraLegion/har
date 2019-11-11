module HAR
  class Cache
    include JSON::Serializable

    @[JSON::Field(key: "beforeRequest")]
    property before_request : CacheRequest?
    @[JSON::Field(key: "afterRequest")]
    property after_request : CacheRequest?
    property comment : String?
  end
end

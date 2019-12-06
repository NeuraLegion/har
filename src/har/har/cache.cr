module HAR
  # This objects contains info about a request coming from browser cache.
  class Cache
    include JSON::Serializable

    # State of a cache entry before the request.
    @[JSON::Field(key: "beforeRequest")]
    property before_request : CacheRequest?

    # State of a cache entry after the request.
    @[JSON::Field(key: "afterRequest")]
    property after_request : CacheRequest?

    # A comment provided by the user or the application.
    property comment : String?
  end
end

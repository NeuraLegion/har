module HAR
  class CacheRequest
    include JSON::Serializable

    # Expiration time of the cache entry.
    property expires : String?

    # The last time the cache entry was opened.
    @[JSON::Field(key: "lastAccess")]
    property last_access : String?

    # Etag
    @[JSON::Field(key: "eTag")]
    property etag : String?

    # The number of times the cache entry has been opened.
    @[JSON::Field(key: "hitCount")]
    property hit_count : Int32?

    # A comment provided by the user or the application.
    property comment : String?

    def initialize(
      @expires = nil,
      @last_access = nil,
      @etag = nil,
      @hit_count = nil,
      @comment = nil
    )
    end
  end
end

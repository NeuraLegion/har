module HAR
  class Entries
    include JSON::Serializable

    property pageref : String?
    @[JSON::Field(key: "startedDateTime")]
    property started_date_time : String
    property time : Int32 | Float32 | Float64?
    property request : Request
    property response : Response
    property cache : Cache?
    property timings : Timings?
    @[JSON::Field(key: "serverIPAddress")]
    property server_ip_address : String?
    property connection : String?
    property comment : String?

    def initialize(@request, @response, @time = nil)
      @started_date_time = Time.utc.to_rfc3339
    end
  end
end

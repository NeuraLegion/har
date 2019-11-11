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
    property timings : Timings | Array(String)?
    @[JSON::Field(key: "serverIPAddress")]
    property server_ip_address : String?
    property connection : String?
    property comment : String?

    def initialize(@request, @response, @time = -1)
      @started_date_time = Time.now.to_rfc3339
    end
  end
end

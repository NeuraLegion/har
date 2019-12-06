module HAR
  class Entries
    include JSON::Serializable

    # Reference to the parent page.
    # Leave out this field if the application does not support grouping by pages.
    property pageref : String?

    # Date and time stamp of the request start (ISO 8601 - `YYYY-MM-DDThh:mm:ss.sTZD`).
    @[JSON::Field(key: "startedDateTime")]
    property started_date_time : String

    # Total elapsed time of the request in milliseconds. This is the sum of all
    # timings available in the timings object (i.e. not including `-1` values) .
    property time : Int32 | Float32 | Float64?

    # Detailed info about the request.
    property request : Request

    # Detailed info about the response.
    property response : Response

    # Info about cache usage.
    property cache : Cache?

    # Detailed timing info about request/response round trip.
    property timings : Timings?

    # IP address of the server that was connected (result of DNS resolution).
    @[JSON::Field(key: "serverIPAddress")]
    property server_ip_address : String?

    # Unique ID of the parent TCP/IP connection, can be the client or server
    # port number. Note that a port number doesn't have to be unique identifier
    # in cases where the port is shared for more connections. If the port isn't
    # available for the application, any other unique connection ID can be used
    # instead (e.g. connection index).
    property connection : String?

    # A comment provided by the user or the application.
    property comment : String?

    def initialize(
      @request,
      @response,
      @pageref = nil,
      @started_date_time = Time.utc.to_rfc3339,
      @time = nil,
      @cache = nil,
      @timings = nil,
      @server_ip_address = nil,
      @connection = nil,
      @comment = nil
    )
    end
  end
end

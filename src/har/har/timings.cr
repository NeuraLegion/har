module HAR
  # This object describes various phases within request-response round trip.
  # All times are specified in milliseconds.
  #
  # The send, wait and receive timings are not optional and must have
  # non-negative values.
  #
  # An exporting tool can omit the blocked, dns, connect and ssl, timings
  # on every request if it is unable to provide them. Tools that can provide
  # these timings can set their values to `-1` if they don’t apply.
  # For example, connect would be `-1` for requests which re-use an existing
  # connection.
  #
  # The time value for the request must be equal to the sum of the timings
  # supplied in this section (excluding any `-1` values).
  #
  # Following must be true in case there are no `-1` values
  # (entry is an object in `log.entries`):
  #
  # ```
  # entry.time == entry.timings.blocked + entry.timings.dns +
  #               entry.timings.connect + entry.timings.send + entry.timings.wait +
  #               entry.timings.receive
  # ```
  class Timings
    include JSON::Serializable

    # Time spent in a queue waiting for a network connection.
    # NOTE: Use `-1` if the timing does not apply to the current request.
    property blocked : Int32 | Float32 | Float64?

    # DNS resolution time. The time required to resolve a host name.
    # NOTE: Use `-1` if the timing does not apply to the current request.
    property dns : Int32 | Float32 | Float64?

    # Time required to create TCP connection.
    # NOTE: Use `-1` if the timing does not apply to the current request.
    property connect : Int32 | Float32 | Float64?

    # Time required to send HTTP request to the server.
    property send : Int32 | Float32 | Float64?

    # Waiting for a response from the server.
    property wait : Int32 | Float32 | Float64?

    # Time required to read entire response from the server (or cache).
    property receive : Int32 | Float64 | Float32?

    # Time required for SSL/TLS negotiation. If this field is defined then
    # the time is also included in the connect field (to ensure backward compatibility with HAR 1.1).
    # NOTE: Use `-1` if the timing does not apply to the current request.
    property ssl : Int32 | Float32 | Float64?

    # A comment provided by the user or the application.
    property comment : String?
  end
end

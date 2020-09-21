module HAR
  class WebSocketMessage
    include JSON::Serializable

    # Type of the message (send/receive).
    property type : String

    # Timing it took to send/receive the message.
    property time : Float64

    # Websocket message operation code.
    property opcode : Int32

    # The data passed over the websocket message.
    property data : String

    def initialize(
      @type,
      @time,
      @opcode,
      @data
    )
    end
  end
end

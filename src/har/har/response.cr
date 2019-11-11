module HAR
  class Response
    include JSON::Serializable

    property status : Int32
    @[JSON::Field(key: "statusText")]
    property status_text : String
    @[JSON::Field(key: "httpVersion")]
    property http_version : String
    property cookies : Array(Cookie)
    property headers : Array(Header)
    property content : Content
    @[JSON::Field(key: "redirectURL")]
    property redirect_url : String?
    @[JSON::Field(key: "headersSize")]
    property headers_size : Int32?
    @[JSON::Field(key: "bodySize")]
    property body_size : Int32?
    property comment : String?

    def initialize(
      @status, @status_text,
      @http_version,
      @content,
      @redirect_url = nil,
      @headers_size = -1,
      @body_size = -1
    )
      @cookies = Array(Cookie).new
      @headers = Array(Header).new
    end
  end
end

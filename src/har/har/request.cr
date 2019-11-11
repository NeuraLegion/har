module HAR
  class Request
    include JSON::Serializable

    property method : String
    property url : String
    @[JSON::Field(key: "httpVersion")]
    property http_version : String
    property cookies : Array(Cookie)
    property headers : Array(Header)
    @[JSON::Field(key: "queryString")]
    property query_string : Array(QueryString)
    @[JSON::Field(key: "postData")]
    property post_data : PostData?
    @[JSON::Field(key: "headersSize")]
    property headers_size : Int32?
    @[JSON::Field(key: "bodySize")]
    property body_size : Int32?
    property comment : String?
    property fragments : Array(String)?

    def initialize(@method, @url, @http_version, @headers_size = nil, @body_size = nil)
      @cookies = Array(Cookie).new
      @headers = Array(Header).new
      @query_string = Array(QueryString).new
    end
  end
end

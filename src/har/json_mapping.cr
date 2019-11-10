require "json"

module HAR
  # Main Data Structure
  class Data
    include JSON::Serializable

    property log : Log

    def initialize(@log)
    end
  end

  class Log
    include JSON::Serializable

    property version : String
    property creator : Creator
    property browser : Browser?
    property pages : Array(Pages)?
    property comment : String?
    property entries : Array(Entries)

    def initialize
      @entries = Array(Entries).new
      @version = "1.2"
      @creator = Creator.new
      @browser = Browser.new
    end
  end

  class Creator
    include JSON::Serializable

    property name : String
    property version : String
    property comment : String?

    def initialize
      @name = "Crystal HAR"
      @version = HAR::VERSION
    end
  end

  class Browser
    include JSON::Serializable

    property name : String
    property version : String
    property comment : String?

    def initialize
      @name = "Crystal HAR"
      @version = HAR::VERSION
    end
  end

  class Pages
    include JSON::Serializable

    @[JSON::Field(key: "startedDateTime")]
    property started_date_time : String?
    property id : String?
    property title : String?
    @[JSON::Field(key: "pageTimings")]
    property page_timings : PageTimings?
    property comment : String?

    def initialize(@started_date_time, @id, @title, @page_timings = nil)
    end
  end

  class PageTimings
    include JSON::Serializable

    @[JSON::Field(key: "onContentLoad")]
    property on_content_load : Int32 | Float32 | Float64?
    @[JSON::Field(key: "onLoad")]
    property on_load : Int32 | Float32 | Float64?
    property comment : String?
  end

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

    def initialize(@method, @url, @http_version, @headers_size = -1, @body_size = -1)
      @cookies = Array(Cookie).new
      @headers = Array(Header).new
      @query_string = Array(QueryString).new
    end
  end

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

  class Cookie
    include JSON::Serializable

    property name : String
    property value : String
    property path : String?
    property domain : String?
    property expires : String | Hash(String, String)?
    @[JSON::Field(key: "httpOnly")]
    property http_only : Bool?
    property secure : Bool?
    property comment : String?

    def initialize(@name, @value)
    end
  end

  class Header
    include JSON::Serializable

    property name : String
    property value : String
    property comment : String?

    def initialize(@name, @value)
    end
  end

  class QueryString
    include JSON::Serializable

    property name : String
    property value : String
    property comment : String?

    def initialize(@name, @value)
    end
  end

  class PostData
    include JSON::Serializable

    @[JSON::Field(key: "mimeType")]
    property mime_type : String?
    property params : Array(Param)?
    property text : String?
    property comment : String?

    def initialize(@text)
    end
  end

  class Param
    include JSON::Serializable

    property name : String
    property value : String?
    @[JSON::Field(key: "fileName")]
    property file_name : String?
    @[JSON::Field(key: "contentType")]
    property content_type : String?
    property comment : String?

    def initialize(@name, @value = nil)
    end
  end

  class Content
    include JSON::Serializable

    property size : Int32?
    property compression : Int32?
    @[JSON::Field(key: "mimeType")]
    property mime_type : String?
    property text : String?
    property encoding : String?
    property comment : String?

    def initialize(@text)
      @size = @text.to_s.size
    end
  end

  class Cache
    include JSON::Serializable

    @[JSON::Field(key: "beforeRequest")]
    property before_request : CacheRequest?
    @[JSON::Field(key: "afterRequest")]
    property after_request : CacheRequest?
    property comment : String?
  end

  class CacheRequest
    include JSON::Serializable

    property expires : String | Bool?
    @[JSON::Field(key: "lastAccess")]
    property last_access : String?
    @[JSON::Field(key: "eTag")]
    property etag : String | Bool?
    @[JSON::Field(key: "hitCount")]
    property hit_count : Int32?
    property comment : String?

    def initialize(@last_access, @etag, @hit_count)
    end
  end

  class Timings
    include JSON::Serializable

    property blocked : Int32 | Float32 | Float64?
    property dns : Int32 | Float32 | Float64?
    property connect : Int32 | Float32 | Float64?
    property send : Int32 | Float32 | Float64?
    property wait : Int32 | Float32 | Float64?
    property receive : Int32 | Float64 | Float32?
    property ssl : Int32 | Float32 | Float64?
    property comment : String?
  end
end

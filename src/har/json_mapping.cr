require "json"

module HAR
  # Main Data Structure
  class Data
    include JSON::Serializable

    property log : Log

    def initialize(@log : Log)
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

    property startedDateTime : String
    property id : String
    property title : String
    property pageTimings : PageTimings
    property comment : String?

    def initialize(@startedDateTime : String, @id : String, @title : String, @pageTimings : PageTimings = PageTimings.new)
    end
  end

  class PageTimings
    include JSON::Serializable

    property onContentLoad : Int32? | Float32? | Float64?
    property onLoad : Int32? | Float32? | Float64?
    property comment : String?
  end

  class Entries
    include JSON::Serializable

    property pageref : String?
    property startedDateTime : String
    property time : Int32? | Float32? | Float64?
    property request : Request
    property response : Response
    property cache : Cache?
    property timings : Timings? | Array(String)?
    property serverIPAddress : String?
    property connection : String?
    property comment : String?

    def initialize(@request : Request, @response : Response, @time = -1)
      @startedDateTime = Time.now.to_rfc3339
      @timings = Timings.new
    end
  end

  class Request
    include JSON::Serializable

    property method : String
    property url : String
    property httpVersion : String
    property cookies : Array(Cookie)
    property headers : Array(Header)
    property queryString : Array(QueryString)
    property postData : PostData?
    property headersSize : Int32?
    property bodySize : Int32?
    property comment : String?
    property fragments : Array(String)?

    def initialize(@method : String, @url : String, @httpVersion : String, @headersSize : Int32? = -1, @bodySize : Int32? = -1)
      @cookies = Array(Cookie).new
      @headers = Array(Header).new
      @queryString = Array(QueryString).new
    end
  end

  class Response
    include JSON::Serializable

    property status : Int32
    property statusText : String
    property httpVersion : String
    property cookies : Array(Cookie)
    property headers : Array(Header)
    property content : Content
    property redirectURL : String?
    property headersSize : Int32?
    property bodySize : Int32?
    property comment : String?

    def initialize(@status : Int32, @statusText : String, @httpVersion : String, @content : Content, @redirectURL : String = "", @headersSize : Int32? = -1, @bodySize : Int32? = -1)
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
    property expires : String | Hash(String, String) | Nil
    property httpOnly : Bool?
    property secure : Bool?
    property comment : String?

    def initialize(@name : String, @value : String)
    end
  end

  class Header
    include JSON::Serializable

    property name : String
    property value : String
    property comment : String?

    def initialize(@name : String, @value : String)
    end
  end

  class QueryString
    include JSON::Serializable

    property name : String
    property value : String
    property comment : String?

    def initialize(@name : String, @value : String)
    end
  end

  class PostData
    include JSON::Serializable

    property mimeType : String?
    property params : Array(Param)?
    property text : String?
    property comment : String?

    def initialize(@text : String)
    end
  end

  class Param
    include JSON::Serializable

    property name : String
    property value : String?
    property fileName : String?
    property contentType : String?
    property comment : String?

    def initialize(@name : String, @value : String? = nil)
    end
  end

  class Content
    include JSON::Serializable

    property size : Int32?
    property compression : Int32?
    property mimeType : String?
    property text : String?
    property encoding : String?
    property comment : String?
  end

  class Cache
    include JSON::Serializable

    property beforeRequest : CacheRequest?
    property afterRequest : CacheRequest?
    property comment : String?
  end

  class CacheRequest
    include JSON::Serializable

    property expires : String?
    property lastAccess : String
    property eTag : String
    property hitCount : Int32
    property comment : String?

    def initialize(@lastAccess : String, @eTag : String, @hitCount : Int32)
    end
  end

  class Timings
    include JSON::Serializable

    property blocked : Int32? | Float32? | Float64?
    property dns : Int32? | Float32? | Float64?
    property connect : Int32? | Float32? | Float64?
    property send : Int32? | Float32? | Float64?
    property wait : Int32? | Float32? | Float64?
    property receive : Int32? | Float64? | Float32?
    property ssl : Int32? | Float32? | Float64?
    property comment : String?
  end
end

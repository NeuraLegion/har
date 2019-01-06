require "json"

module HAR
  # Main Data Structure
  class Data
    include JSON::Serializable

    property log : Log
  end

  class Log
    include JSON::Serializable

    property version : String
    property creator : Creator
    property browser : Browser?
    property pages : Array(Pages)?
    property comment : String?
    property entries : Array(Entries)
  end

  class Creator
    include JSON::Serializable

    property name : String
    property version : String
    property comment : String?
  end

  class Browser
    include JSON::Serializable

    property name : String
    property version : String
    property comment : String?
  end

  class Pages
    include JSON::Serializable

    property startedDateTime : String
    property id : String
    property title : String
    property pageTimings : PageTimings
    property comment : String?
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
  end

  class Response
    include JSON::Serializable

    property status : Int32
    property statusText : String
    property httpVersion : String
    property cookies : Array(Cookie)
    property headers : Array(Header)
    property content : Content
    property redirectURL : String
    property headersSize : Int32?
    property bodySize : Int32?
    property comment : String?
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
  end

  class Header
    include JSON::Serializable

    property name : String
    property value : String
    property comment : String?
  end

  class QueryString
    include JSON::Serializable

    property name : String
    property value : String
    property comment : String?
  end

  class PostData
    include JSON::Serializable

    property mimeType : String?
    property params : Array(Param)?
    property text : String
    property comment : String?
  end

  class Param
    include JSON::Serializable

    property name : String
    property value : String?
    property fileName : String?
    property contentType : String?
    property comment : String?
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

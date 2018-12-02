require "json"

module HAR
  # Main Data Structure
  class Data
    JSON.mapping(
      log: Log
    )
  end

  class Log
    JSON.mapping(
      version: String,
      creator: Creator,
      browser: Browser?,
      pages: Array(Pages)?,
      comment: String?,
      entries: Array(Entries),
    )
  end

  class Creator
    JSON.mapping(
      name: String,
      version: String,
      comment: String?,
    )
  end

  class Browser
    JSON.mapping(
      name: String,
      version: String,
      comment: String?,
    )
  end

  class Pages
    JSON.mapping(
      startedDateTime: String,
      id: String,
      title: String,
      pageTimings: PageTimings,
      comment: String?
    )
  end

  class PageTimings
    JSON.mapping(
      onContentLoad: Int32? | Float32? | Float64?,
      onLoad: Int32? | Float32? | Float64?,
      comment: String?,
    )
  end

  class Entries
    JSON.mapping(
      pageref: String?,
      startedDateTime: String,
      time: Int32? | Float32? | Float64?,
      request: Request,
      response: Response,
      cache: Cache?,
      timings: Timings? | Array(String)? | Hash(String, String)?,
      serverIPAddress: String?,
      connection: String?,
      comment: String?
    )
  end

  class Request
    JSON.mapping(
      method: String,
      url: String,
      httpVersion: String,
      cookies: Array(Cookie),
      headers: Array(Header),
      queryString: Array(QueryString),
      postData: PostData?,
      headersSize: Int32?,
      bodySize: Int32?,
      comment: String?,
      fragments: Array(String)?
    )
  end

  class Response
    JSON.mapping(
      status: Int32,
      statusText: String,
      httpVersion: String,
      cookies: Array(Cookie),
      headers: Array(Header),
      content: Content,
      redirectURL: String,
      headersSize: Int32?,
      bodySize: Int32?,
      comment: String?,
    )
  end

  class Cookie
    JSON.mapping(

      name: String,
      value: String,
      path: String?,
      domain: String?,
      expires: String | Hash(String, String) | Nil,
      httpOnly: Bool?,
      secure: Bool?,
      comment: String?,
    )
  end

  class Header
    JSON.mapping(
      name: String,
      value: String,
      comment: String?,
    )
  end

  class QueryString
    JSON.mapping(
      name: String,
      value: String,
      comment: String?
    )
  end

  class PostData
    JSON.mapping(
      mimeType: String?,
      params: Array(Param)?,
      text: String,
      comment: String?
    )
  end

  class Param
    JSON.mapping(
      name: String,
      value: String?,
      fileName: String?,
      contentType: String?,
      comment: String?
    )
  end

  class Content
    JSON.mapping(
      size: Int32?,
      compression: Int32?,
      mimeType: String?,
      text: String?,
      encoding: String?,
      comment: String?,
    )
  end

  class Cache
    JSON.mapping(
      beforeRequest: CacheRequest?,
      afterRequest: CacheRequest?,
      comment: String?,
    )
  end

  class CacheRequest
    JSON.mapping(
      expires: String?,
      lastAccess: String,
      eTag: String,
      hitCount: Int32,
      comment: String?
    )
  end

  class Timings
    JSON.mapping(
      blocked: Int32? | Float32? | Float64?,
      dns: Int32? | Float32? | Float64?,
      connect: Int32? | Float32? | Float64?,
      send: Int32? | Float32? | Float64?,
      wait: Int32? | Float32? | Float64?,
      receive: Int32 | Float64 | Float32,
      ssl: Int32? | Float32? | Float64?,
      comment: String?
    )
  end
end

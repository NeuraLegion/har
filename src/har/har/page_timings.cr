module HAR
  # This object describes timings for various events (states) fired during
  # the page load. All times are specified in milliseconds.
  #
  # NOTE: If a time info is not available appropriate field is set to `-1`.
  #
  # Depeding on the browser, `on_content_load` property represents
  # `DOMContentLoad` event or `document.readyState == interactive`.
  class PageTimings
    include JSON::Serializable

    # Content of the page loaded. Number of milliseconds since
    # page load started (`page.startedDateTime`).
    # NOTE: Use `-1` if the timing does not apply to the current request.
    @[JSON::Field(key: "onContentLoad")]
    property on_content_load : Float64?

    # Page is loaded (onLoad event fired). Number of milliseconds
    # since page load started (`page.startedDateTime`).
    # NOTE: Use `-1` if the timing does not apply to the current request.
    @[JSON::Field(key: "onLoad")]
    property on_load : Int32 | Float32 | Float64?

    # A comment provided by the user or the application.
    property comment : String?

    def initialize(
      @on_content_load = nil,
      @on_load = nil,
      @comment = nil
    )
    end
  end
end

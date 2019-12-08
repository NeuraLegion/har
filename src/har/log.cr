module HAR
  # This object represents the root of exported data.
  #
  # There is one `Page` object for every exported web page and one `Entry` object
  # for every HTTP request. In case when an HTTP trace tool isn't able to group
  # requests by a page, the `Log#pages` array is empty and individual requests
  # doesn't have a parent page.
  class Log
    include JSON::Serializable

    # Version number of the format. If empty, string `"1.1"` is assumed by default.
    property version : String

    # Name and version info of the log creator application.
    property creator : Creator

    # Name and version info of used browser.
    property browser : Browser?

    # List of all exported (tracked) pages.
    # Leave out this field if the application does not support grouping by pages.
    property pages : Array(Page)?

    # This object represents an array with all exported (tracked) HTTP requests.
    # Sorting entries by `Entry#started_date_time` (starting from the oldest) is preferred
    # way how to export data since it can make importing faster.
    # However the reader application should always make sure the array is sorted
    # (if required for the import).
    property entries : Array(Entry)

    # A comment provided by the user or the application.
    property comment : String?

    def initialize(
      @version = "1.2",
      @creator = Creator.new,
      @browser = Browser.new,
      @entries = Array(Entry).new,
      @pages = nil,
      @comment = nil
    )
    end
  end
end

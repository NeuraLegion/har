module HAR
  # `Creator` and `Browser` objects share the same structure.
  class Browser
    include JSON::Serializable

    # Name of the application/browser used to export the log.
    property name : String

    # Version of the application/browser used to export the log.
    property version : String

    # A comment provided by the user or the application.
    property comment : String?

    def initialize
      @name = "Crystal HAR"
      @version = HAR::VERSION
    end
  end
end

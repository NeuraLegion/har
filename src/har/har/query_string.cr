module HAR
  # Parameter NVP (name-value pair) parsed from a query string, if any
  # (embedded in `Request` object).
  class QueryString
    include JSON::Serializable

    # Name of a header.
    property name : String

    # Value of a query string param.
    property value : String

    # A comment provided by the user or the application.
    property comment : String?

    def initialize(@name, @value)
    end
  end
end

module HAR
  class Header
    include JSON::Serializable

    # Name of a header.
    property name : String

    # Value of a header.
    property value : String

    # A comment provided by the user or the application.
    property comment : String?

    def initialize(@name, @value)
    end
  end
end

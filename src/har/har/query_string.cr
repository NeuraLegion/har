module HAR
  class QueryString
    include JSON::Serializable

    property name : String
    property value : String
    property comment : String?

    def initialize(@name, @value)
    end
  end
end

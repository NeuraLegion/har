module HAR
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
end

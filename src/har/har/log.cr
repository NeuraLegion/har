module HAR
  class Log
    include JSON::Serializable

    property version : String
    property creator : Creator
    property browser : Browser?
    property pages : Array(Pages)?
    property entries : Array(Entries)
    property comment : String?

    def initialize
      @entries = Array(Entries).new
      @version = "1.2"
      @creator = Creator.new
      @browser = Browser.new
    end
  end
end

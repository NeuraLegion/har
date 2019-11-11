module HAR
  class Log
    include JSON::Serializable

    property version : String
    property creator : Creator
    property browser : Browser?
    property pages : Array(Pages)?
    property comment : String?
    property entries : Array(Entries)

    def initialize
      @entries = Array(Entries).new
      @version = "1.2"
      @creator = Creator.new
      @browser = Browser.new
    end
  end
end

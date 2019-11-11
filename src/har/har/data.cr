module HAR
  # Main Data Structure
  class Data
    include JSON::Serializable

    property log : Log

    def initialize(@log)
    end
  end
end

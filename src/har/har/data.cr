module HAR
  # Main Data Structure
  class Data
    include JSON::Serializable

    # This object represents the root of exported data.
    property log : Log

    def initialize(@log)
    end
  end
end

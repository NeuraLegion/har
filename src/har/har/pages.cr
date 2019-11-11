module HAR
  class Pages
    include JSON::Serializable

    @[JSON::Field(key: "startedDateTime")]
    property started_date_time : String?
    property id : String?
    property title : String?
    @[JSON::Field(key: "pageTimings")]
    property page_timings : PageTimings?
    property comment : String?

    def initialize(@started_date_time, @id, @title, @page_timings = nil)
    end
  end
end

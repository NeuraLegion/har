module HAR
  # This module is used to skip ill-formed timestamps
  module TimeConverter
    Log = ::Log.for(self)

    def self.from_json(pull : JSON::PullParser)
      raw_string = pull.read_string
      begin
        return Time::Format::ISO_8601_DATE_TIME.parse(raw_string)
      rescue ex
        ::Log.warn(exception: ex) { "Unable to parse timestamp #{raw_string.inspect}" }
      end
      raw_string
    end

    def self.to_json(value : Time, build : JSON::Builder)
      build.string(Time::Format::ISO_8601_DATE_TIME.format(value))
    end
  end
end

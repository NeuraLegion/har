module HAR
  class PostData
    include JSON::Serializable

    @[JSON::Field(key: "mimeType")]
    property mime_type : String?
    property params : Array(Param)?
    property text : String?
    property comment : String?

    def initialize(@text)
    end

    def http_params : HTTP::Params
      HTTP::Params.new.tap do |http_params|
        params.try &.each do |param|
          next unless value = param.value
          http_params[param.name] = value
        end
      end
    end

    def http_params=(http_params : HTTP::Params)
      @params = params = Array(Param).new
      http_params.each do |key, value|
        params[key] = value
      end
    end
  end
end

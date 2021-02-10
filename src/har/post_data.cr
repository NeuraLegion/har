module HAR
  # This object describes posted data, if any (embedded in `Request` object).
  #
  # NOTE: `text` and `params` fields are mutually exclusive.
  class PostData
    include JSON::Serializable

    # Mime type of posted data.
    @[JSON::Field(key: "mimeType")]
    property mime_type : String?

    # List of posted parameters (in case of URL encoded parameters).
    property params : Array(Param)?

    # Plain text posted data.
    property text : String?

    # A comment provided by the user or the application.
    property comment : String?

    def initialize(
      @mime_type = nil,
      @params = nil,
      @text = nil,
      @comment = nil
    )
    end

    def http_params : URI::Params
      URI::Params.new.tap do |http_params|
        params.try &.each do |param|
          next unless value = param.value
          http_params[param.name] = value
        end
      end
    end

    def http_params=(http_params : URI::Params)
      @params = params = Array(Param).new
      http_params.each do |key, value|
        params[key] = value
      end
    end
  end
end

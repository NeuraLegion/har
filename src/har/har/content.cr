module HAR
  # This object describes details about response content (embedded in `Response` object).
  #
  # NOTE: Before setting the text field, the HTTP response is decoded
  # (decompressed & unchunked), than trans-coded from its original character
  # set into UTF-8. Additionally, it can be encoded using e.g. base64.
  # Ideally, the application should be able to unencode a base64 blob and
  # get a byte-for-byte identical resource to what the browser operated on.
  #
  # NOTE: Encoding field is useful for including binary responses (e.g. images) into the HAR file.
  class Content
    include JSON::Serializable

    # Length of the returned content in bytes. Should be equal to `response.body_size`
    # if there is no compression and bigger when the content has been compressed.
    property size : Int32?

    # Number of bytes saved.
    property compression : Int32?

    # MIME type of the response text (value of the `Content-Type` response header).
    # The charset attribute of the MIME type is included (if available).
    @[JSON::Field(key: "mimeType")]
    property mime_type : String?

    # Response body sent from the server or loaded from the browser cache.
    # This field is populated with textual content only.
    # The text field is either HTTP decoded text or a encoded (e.g. `base64`)
    # representation of the response body.
    property text : String?

    # Encoding used for response text field e.g `base64`.
    # Leave out this field if the text field is HTTP decoded (decompressed & unchunked),
    # than trans-coded from its original character set into UTF-8.
    property encoding : String?

    # A comment provided by the user or the application.
    property comment : String?

    def initialize(@text)
      @size = @text.to_s.size
    end
  end
end

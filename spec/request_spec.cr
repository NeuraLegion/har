require "./spec_helper"

describe "Request spec" do
  it "parses HAR file" do
    v = "{\"visits\":\"[1639294637]\",\"campaigns_status\":{\"30436\":1639294638}}"
    cookies = Array(HAR::Cookie).new
    cookies << HAR::Cookie.new(name: "a", value: v)
    request = HAR::Request.new(method: "GET", url: "0.0.0.0", http_version: "HTTP/1.1", cookies: cookies)
    request = request.to_http_request
    request.cookies.size.should eq 0
  end

  context "post body" do
    HAR::Request::FORMDATA_MIME_VALUES.each do |mime_type|
      it "from #{mime_type} params" do
        raw = %q<{
        "url": "https://api.example.com/v2/file",
        "method": "POST",
        "headers": [
            {
                "name": "Authorization",
                "value": "RELEVANT_API_KEY"
            }
        ],
        "queryString": [],
        "cookies": [],
        "postData": {
            "mimeType": "%{mime_type}",
            "params": [
                {
                    "name": "query",
                    "value": "mutation add_file($file: File!) {add_file_to_column (item_id: 1234567890, column_id:\"files\" file: $file) {id}}\n"
                },
                {
                    "name": "map",
                    "value": "{\"image\":\"variables.file\"}\n"
                },
                {
                    "name": "image",
                    "value": ""
                }
            ]
        },
        "headersSize": -1,
        "bodySize": -1,
        "httpVersion": "HTTP/1.1"
      }> % {mime_type: mime_type}
        request = HAR::Request.from_json(raw)
        request.body.should eq "query=mutation+add_file%28%24file%3A+File%21%29+%7Badd_file_to_column+%28item_id%3A+1234567890%2C+column_id%3A%22files%22+file%3A+%24file%29+%7Bid%7D%7D%0A&map=%7B%22image%22%3A%22variables.file%22%7D%0A&image="
      end
    end
  end
end

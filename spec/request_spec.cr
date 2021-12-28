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
end

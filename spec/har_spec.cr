require "./spec_helper"

describe HAR do
  # TODO: Write tests

  it "parses HAR file" do
    file = "#{__DIR__}/data/example.json"
    HAR.from_file(file).should be_a(HAR::Log)
  end

  it "access some relevant data" do
    file = "#{__DIR__}/data/example.json"
    json = HAR.from_file(file)
    Log.debug { json.pretty_inspect }
  end

  it "to_s" do
    file = "#{__DIR__}/data/example.json"
    json = HAR.from_file(file).to_s
    Log.debug { json.pretty_inspect }
  end

  it "to_json" do
    file = "#{__DIR__}/data/example.json"
    json = HAR.from_file(file).to_json
    Log.debug { json.pretty_inspect }
  end

  it "exports HTTP headers propperly" do
    file = "#{__DIR__}/data/example.json"
    har = HAR.from_file(file)
    headers = har.entries.first.request.http_headers
    headers.should be_a(HTTP::Headers)
    headers["cache-control"].should eq("no-cache,test-cache")
  end

  it "doesn't merge request headers with the same name" do
    std_request = HTTP::Request.new(
      method: "GET",
      resource: "/",
      headers: HTTP::Headers{
        "cache-control" => ["no-cache", "test-cache"],
        "cookie"        => ["id=1", "userId=2; foo=bar"],
      }
    )
    request = HAR::Request.new(std_request)
    request.headers.size.should eq(4)
    request.headers.count { |h| h.name == "cookie" }.should eq(2)
  end

  it "doesn't merge response headers with the same name" do
    std_response = HTTP::Client::Response.new(
      status_code: 200,
      body: "Hello world",
      headers: HTTP::Headers{
        "content-type"   => "text/plain",
        "content-length" => "11",
        "set-cookie"     => ["foo=bar; domain=example.com", "userId=1; path=/"],
      }
    )
    response = HAR::Response.new(std_response)
    response.headers.size.should eq(4)
    response.headers.count { |h| h.name == "set-cookie" }.should eq(2)
  end
end

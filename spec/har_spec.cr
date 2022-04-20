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
end

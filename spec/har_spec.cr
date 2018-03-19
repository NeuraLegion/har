require "./spec_helper"

describe HAR do
  # TODO: Write tests

  it "parses HAR file" do
    file = "#{__DIR__}/example_data.json"
    HAR.from_file(file).should be_a(HAR::Log)
  end

  it "access some relevant data" do
    file = "#{__DIR__}/example_data.json"
    json = HAR.from_file(file)
    pp json
  end
end

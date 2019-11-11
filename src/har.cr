require "json"
require "./har/**"

# TODO: Write documentation for `Har`
module HAR
  extend self

  def from_file(file : String) : Log
    from_string(File.read(file))
  end

  def from_string(string : String) : Log
    Data.from_json(string).log
  end
end

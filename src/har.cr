require "./har/**"

# TODO: Write documentation for `Har`
module HAR
  extend self

  def from_file(file : String) : HAR::Log
    f = File.open(file)
    raw = f.gets_to_end
    f.close
    from_string(raw)
  end

  def from_string(string : String) : HAR::Log
    HAR::Data.from_json(string).log
  end
end

require "json"
require "./har/*"

# HTTP Archive v1.2
#
# One of the goals of the HTTP Archive format is to be flexible enough so, it can be adopted
# across projects and various tools. This should allow effective processing and analyzing data
# coming from various sources. Notice that resulting HAR file can contain privacy & security
# sensitive data and user-agents should find some way to notify the user of this fact before
# they transfer the file to anyone else.
module HAR
  extend self

  def from_file(file : String) : Log
    from_string(File.read(file))
  end

  def from_string(string : String) : Log
    Data.from_json(string).log
  end
end

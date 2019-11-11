module HAR
  class Timings
    include JSON::Serializable

    property blocked : Int32 | Float32 | Float64?
    property dns : Int32 | Float32 | Float64?
    property connect : Int32 | Float32 | Float64?
    property send : Int32 | Float32 | Float64?
    property wait : Int32 | Float32 | Float64?
    property receive : Int32 | Float64 | Float32?
    property ssl : Int32 | Float32 | Float64?
    property comment : String?
  end
end

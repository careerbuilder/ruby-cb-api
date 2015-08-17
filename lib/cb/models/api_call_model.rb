module Cb
  module Models
    class ApiCall < Struct.new(:api_call_type, :path, :options, :response, :elapsed_time)
    end
  end
end


module Cb
  class IncomingParamIsWrongTypeException < StandardError; end
  class ResponseContainsNoData            < StandardError; end
  class ExpectedResponseFieldMissing      < StandardError; end
  class ApiResponseError                  < StandardError; end
  class ServiceUnavailable                < StandardError; end
end

module Cb
  class IncomingParamIsWrongTypeException < StandardError; end
  class ExpectedResponseFieldMissing      < StandardError; end
  class ApiResponseError                  < StandardError; end
  class ServiceUnavailableError           < ApiResponseError; end
  class UnauthorizedError                 < ApiResponseError; end
end

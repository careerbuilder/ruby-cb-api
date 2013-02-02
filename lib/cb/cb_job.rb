module Cb
	class CbJob
    attr_accessor :did, :title, :description, :requirements, :begin_date, :end_date

		#############################################################
		### 
		#############################################################
    def initialize(args = {})
      self.did = args[:DID] || ""
      self.title = args[:JobTitle] || ""
      self.description = args[:JobDescription] || ""
      self.requirements = args[:JobRequirements] || ""
      self.begin_date = args[:BeginDate] || ""
      self.end_date = args[:EndDate] || ""
    end
	end
end
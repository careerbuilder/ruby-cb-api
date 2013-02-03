module Cb
	class CbJob
    attr_accessor :did, :title, :pay
    attr_accessor :company, :company_did, :company_details_url, :company_image_url
    attr_accessor :description_teaser, :location, :distance, :latitude, :longitude
    attr_accessor :description, :requirements, :employment_type
    attr_accessor :details_url, :service_url, :similar_jobs_url
    attr_accessor :begin_date, :end_date, :posted_date

		##############################################################
		## This general purpose object stores anything having to do
    ## with a job. The API objects dealing with job, will populate
    ## one or many of these objects.
		##############################################################
    def initialize(args = {})
      # General
      self.did                      = args["DID"] || ""
      self.title                    = args["JobTitle"] || ""
      self.employment_type          = args["EmploymentType"] || ""
      self.latitude                 = args["LocationLatitude"] || ""
      self.longitude                = args["LocationLongitude"] || ""
      self.pay                      = args["Pay"] || ""

      # Job Search related
      self.description_teaser       = args["DescriptionTeaser"] || ""
      self.posted_date              = args["PostedDate"] || ""
      self.distance                 = args["Distance"] || ""
      self.details_url              = args["JobDetailsURL"] || ""
      self.service_url              = args["JobServiceURL"] || ""
      self.location                 = args["Location"] || ""
      self.similar_jobs_url         = args["SimilarJobsURL"] || ""

      # Job Details related
      self.description              = args["Description"] || ""
      self.requirements             = args["JobRequirements"] || ""
      self.begin_date               = args["BeginDate"] || ""
      self.end_date                 = args["EndDate"] || ""

      # Company related
      self.company                  = args["Company"] || ""
      self.company_did              = args["CompanyDID"] || ""
      self.company_details_url      = args["CompanyDetailsURL"] || ""
      self.company_image_url        = args["CompanyImageURL"] || ""
    end
	end
end
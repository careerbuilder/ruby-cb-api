module Cb
  module Models
    class JobResults
      attr_reader :args_hash, :jobs, :total_count, :last_item_index, :city, :state_code, :postal_code, :search_location
      def initialize(args_hash, job_hashes)
        @args_hash = args_hash
        @jobs = extract_jobs(job_hashes)
        @total_count = args_hash['TotalCount']
        @last_item_index = args_hash['LastItemIndex']
        @city = args_hash['City']
        @state_code = args_hash['StateCode']
        @postal_code = args_hash['PostalCode']
        @search_location = [args_hash['SearchMetaData']['SearchLocations']['SearchLocation']].flatten.first rescue nil
      end

      private

      def extract_jobs(job_hashes)
        job_hashes.collect do |job_hash|
          Job.new(job_hash)
        end
      end


    end
  end
end

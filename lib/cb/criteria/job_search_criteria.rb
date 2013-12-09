module Cb
	# Trying to simplify the large number of inputs our job search api accepts
	# For indepth information around all of the different inputs, please visit:
	# http://api.careerbuilder.com/JobSearchInfo.aspx
	####################################################################################
	class JobSearchCriteria
		extend Cb::Utils::FluidAttributes

		fluid_attr_accessor :advanced_grouping_mode, :boolean_operator, :category, :co_brand, :company_did,
                        :company_did_csv, :company_name, :company_name_boost_params, :country_code,
                        :education_code, :emp_type, :enable_company_collapse, :exclude_company_names,
                        :exclude_job_titles, :exclude_keywords, :exclude_national, :exclude_non_traditional_jobs,
                        :exclude_product_id, :facet_category, :facet_company, :facet_city, :facet_state,
                        :facet_city_state, :facet_pay, :facet_normalized_company_did, :host_site,
                        :include_company_children, :industry_codes, :job_title, :keywords, :location,
                        :normalized_company_did, :normalized_company_did_boost_params,
                        :normalized_company_name, :onet_code, :order_by, :order_direction, :page_number,
                        :partner_id, :pay_high, :pay_info_only, :pay_low, :per_page, :posted_within,
                        :product_id, :radius, :records_per_group, :relocate_jobs, :soc_code, :school_site_id,
                        :search_all_countries, :search_view, :show_categories, :show_apply_requirements,
                        :apply_requirements, :exclude_apply_requirements, :single_onet_search, :site_entity, :site_id, :skills, :specific_education,
                        :spoken_language, :tags, :talent_network_did, :url_compression_service, :use_facets,
                        :str_crit

		def search
			Cb::Clients::JobApi.search(Cb::Utils::Api.criteria_to_hash(self))
		end
	end
end
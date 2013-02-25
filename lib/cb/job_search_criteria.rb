module Cb
	# Trying to simplify the large number of inputs our job search api accepts
	# For indepth information around all of the different inputs, please visit:
	# http://api.careerbuilder.com/JobSearchInfo.aspx
	####################################################################################
	class JobSearchCriteria
		extend FluidAttributes

		fluid_attr_accessor :advanced_grouping, :boolean_operator, :category, :co_brand, :company_did,
							:company_did_csv, :company_name, :company_name_boost, :country_code,
							:education_code, :employer_type, :enable_company_collapse, :exclude_company_names,
							:exclude_job_titles, :exclude_keywords, :exclude_national, :exclude_mlms,
							:exclude_product, :facet_category, :facet_company, :facet_city, :facet_state,
							:facet_city_state, :facet_pay, :facet_normalized_company_did, :host_site,
							:include_company_children, :industry_codes, :job_title, :keywords, :location,
							:normalized_company_did, :normalized_company_did_boost_params, 
							:normalized_company_name, :onet, :order_by, :order_direction, :page_number,
							:partner_id, :pay_high, :pay_info_only, :pay_low, :per_page, :posted_within,
							:product, :radius, :records_per_group, :relocate_jobs, :soc, :school_id,
							:search_all_countries, :search_view, :show_categories, :show_apply_requirements,
							:apply_requirements, :single_onet, :site_entity, :site_id, :skills, :specific_education,
							:spoken_language, :tags, :talent_network_did, :url_compression_service, :use_facets,
							:str_crit

		def search()
			p Cb::CbJobApi.methods(false)
			Cb::CbJobApi.search(self.to_hash)
		end

		def to_hash
			ret = {}

			ret.merge!(:AdvancedGroupingMode => 				    @advanced_grouping) unless @advanced_grouping.nil?
			ret.merge!(:BooleanOperator => 						      @boolean_operator) unless @boolean_operator.nil?
			ret.merge!(:Category => 							          @category) unless @category.nil?
			ret.merge!(:CoBrand => 								          @co_brand) unless @co_brand.nil?
			ret.merge!(:CompanyDID => 							        @company_did) unless @company_did.nil?
			ret.merge!(:CompanyDIDCSV => 						        @company_did_csv) unless @company_did_csv.nil?
			ret.merge!(:CompanyName => 							        @company_name) unless @company_name.nil?
			ret.merge!(:CompanyNameBoostParams => 			    @company_name_boost) unless @company_name_boost.nil?
			ret.merge!(:CountryCode => 							        @country_code) unless @country_code.nil?
			ret.merge!(:EducationCode => 						        @education_code) unless @education_code.nil?
			ret.merge!(:EmpType => 								          @employer_type) unless @employer_type.nil?
			ret.merge!(:EnableCompanyCollapse => 				    @enable_company_collapse) unless @enable_company_collapse.nil?
			ret.merge!(:ExcludeCompanyNames => 					    @exclude_company_names) unless @exclude_company_names.nil?
			ret.merge!(:ExcludeJobTitles => 					      @exclude_job_titles) unless @exclude_job_titles.nil?
			ret.merge!(:ExcludeKeywords => 						      @exclude_keywords) unless @exclude_keywords.nil?
			ret.merge!(:ExcludeNational => 						      @exclude_national) unless @exclude_national.nil?
			ret.merge!(:ExcludeNonTraditionalJobs => 		    @exclude_mlms) unless @exclude_mlms.nil?
			ret.merge!(:ExcludeProductID => 					      @exclude_product) unless @exclude_product.nil?
			ret.merge!(:FacetCategory => 						        @facet_category) unless @facet_category.nil?
			ret.merge!(:FacetCompany => 						        @facet_company) unless @facet_company.nil?
			ret.merge!(:FacetCity => 							          @facet_city) unless @facet_city.nil?
			ret.merge!(:FacetState => 							        @facet_state) unless @facet_state.nil?
			ret.merge!(:FacetCityState => 						      @facet_city_state) unless @facet_city_state.nil?
			ret.merge!(:FacetPay => 							          @facet_pay) unless @facet_pay.nil?
			ret.merge!(:FacetNormalizedCompanyDID => 		    @facet_normalized_company_did) unless @facet_normalized_company_did.nil?
			ret.merge!(:HostSite => 							          @host_site) unless @host_site.nil?
			ret.merge!(:IncludeCompanyChildren => 			    @include_company_children) unless @include_company_children.nil?
			ret.merge!(:IndustryCodes => 						        @industry_codes) unless @industry_codes.nil?
			ret.merge!(:JobTitle => 							          @job_title) unless @job_title.nil?
			ret.merge!(:Keywords => 							          @keywords) unless @keywords.nil?
			ret.merge!(:Location => 							          @location) unless @location.nil?
			ret.merge!(:NormalizedCompanyDID => 				    @normalized_company_did) unless @normalized_company_did.nil?
			ret.merge!(:NormalizedCompanyDIDBoostParams => 	@normalized_company_did_boost_params) unless @normalized_company_did_boost_params.nil?
			ret.merge!(:NormalizedCompanyName => 				    @normalized_company_name) unless @normalized_company_name.nil?
			ret.merge!(:ONetCode => 							          @onet) unless @onet.nil?
			ret.merge!(:OrderBy => 								          @order_by) unless @order_by.nil?
			ret.merge!(:OrderDirection => 						      @order_direction) unless @order_direction.nil?
			ret.merge!(:PageNumber => 							        @page_number) unless @page_number.nil?
			ret.merge!(:PartnerID => 							          @partner_id) unless @partner_id.nil?
			ret.merge!(:PayHigh => 								          @pay_high) unless @pay_high.nil?
			ret.merge!(:PayInfoOnly => 							        @pay_info_only) unless @pay_info_only.nil?
			ret.merge!(:PayLow => 								          @pay_low) unless @pay_low.nil?
			ret.merge!(:PerPage => 								          @per_page) unless @per_page.nil?
			ret.merge!(:PostedWithin => 						        @posted_within) unless @posted_within.nil?
			ret.merge!(:ProductID => 							          @product) unless @product.nil?
			ret.merge!(:Radius => 								          @radius) unless @radius.nil?
			ret.merge!(:RecordsPerGroup => 						      @records_per_group) unless @records_per_group.nil?
			ret.merge!(:RelocateJobs => 						        @relocate_jobs) unless @relocate_jobs.nil?
			ret.merge!(:SOCCode => 								          @soc) unless @soc.nil?
			ret.merge!(:SchoolSiteID => 						        @school_id) unless @school_id.nil?
			ret.merge!(:SearchAllCountries => 					    @search_all_countries) unless @search_all_countries.nil?
			ret.merge!(:SearchView => 							        @search_view) unless @search_view.nil?
			ret.merge!(:ShowCategories => 						      @show_categories) unless @show_categories.nil?
			ret.merge!(:ShowApplyRequirements => 				    @show_apply_requirements) unless @show_apply_requirements.nil?
			ret.merge!(:ApplyRequirements => 					      @apply_requirements) unless @apply_requirements.nil?
			ret.merge!(:SingleONetSearch => 					      @single_onet) unless @single_onet.nil?
			ret.merge!(:SiteEntity => 							        @site_entity) unless @site_entity.nil?
			ret.merge!(:SiteID => 								          @site_id) unless @site_id.nil?
			ret.merge!(:Skills => 								          @skills) unless @skills.nil?
			ret.merge!(:SpecificEducation => 					      @specific_education) unless @specific_education.nil?
			ret.merge!(:SpokenLanguage => 						      @spoken_language) unless @spoken_language.nil?
			ret.merge!(:Tags => 								            @tags) unless @tags.nil?
			ret.merge!(:TalentNetworkDID => 					      @talent_network_did) unless @talent_network_did.nil?
			ret.merge!(:UrlCompressionService => 				    @url_compression_service) unless @url_compression_service.nil?
			ret.merge!(:UseFacets => 							          @use_facets) unless @use_facets.nil?
			ret.merge!(:strcrit => 								          @str_crit) unless @str_crit.nil?

			return ret
		end
	end
end
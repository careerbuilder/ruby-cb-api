First things first. You're going to need to get a developer key from Careerbuilder. Developer keys are available to Partners. You can fill out the form at http://developer.careerbuilder.com/partner_messages/new to become a Partner.

Now that you have a key, lets get to the good stuff.

You can find an example rails site that uses the gem here:
https://github.com/cbdr/ruby-cb-api-demo

Installation
================

Install required gems:

    gem install iconv
    gem install cb-api

Require the library in your Ruby script:

    require 'cb'

Configuration
================
Set your dev key, and any other configuration settings in a place that will run prior to your API calls.

    Cb.configure do |config|
      config.dev_key  	= 'your-dev-key-goes-here'
      config.time_out 	= 5
    end

Available Endpoints
================
https://github.com/cbdr/ruby-cb-api/blob/master/lib/cb/config.rb

Job Search
================

Use the `Cb` convenience methods to access the job client (`Cb::Clients::Job`)

    job_client = Cb.job

Using the job client you can search through the listings

    job_client.search({ location: 'Atlanta' })

Or you can search for one job via it's details

    job_client.find_by_criteria({ })

Or you can search for one job via it's `did`

    job_client.find_by_did('J3H4CK6XNXYQ07RHSYL')

When using the job client to do a search you will receive back a search response instance (`Response::Job::Search`)

    search_response = job_client.search({ location: 'Atlanta' })

Which can be used to retrieve an search result model instance (`Cb::Models::JobResults`)

    search_result_model = search_response.model

Which encapsulates details of the search result

    search_result.total_count
    search_result.last_item_index
    search_result.city
    search_result.state
    search_result.postal_code
    search_result.search_location

As well as returning back the jobs from the search result (`Cb::Models::Job` instances)

    jobs = search_result.jobs

Each returned job object contains details of one job listing

    jobs.each do |job|
      puts "#{job.did}: #{job.company_name} - #{job.title}"
    end

The search response can also return you any errors which occured during the job search (`Cb::Responses::Errors`). The parsed errors will contain an `Array` of error messages. If it is not empty an error occurred during the request.

    search_response.errors.parsed

Job Search params
=================

When performing a job search you can provide a `Hash` of search parameters. For example

    search_params = { location: 'Atlanta', keywords: 'Database Admin' }
    Cb.job.search(search_params)

The search params hash can include the following keys:

* keywords
* location
* postedwithin
* excludeapplyrequirments
* orderdirection
* orderby
* pagenumber
* hostsite
* siteentity
* countrycode

Job details
===========

`Cb::Models::Job` has many accessor methods which are used to get the details of the job

If you have preformed a job search, such as

    Cb.job.search({ location: 'Atlanta' }).results.model.jobs.each do |job|
      puts "Job Details: #{job.company_name} - #{job.title}"
    end

The following data is available from a job

* `did`
* `title`
* `job_skin`
* `job_skin_did`
* `job_branding`
* `pay`
* `pay_per`
* `commission`
* `bonus`
* `pay_other`
* `categories`
* `category_codes`
* `degree_required`
* `experience_required`
* `travel_required`
* `industry_codes`
* `manages_others_code`
* `contact_email_url`
* `contact_fax`
* `contact_name`
* `contact_phone`
* `company_name`
* `company_did`
* `company_details_url`
* `company_image_url`
* `company`
* `description_teaser`
* `external_apply_url`
* `job_tracking_url`
* `location`
* `distance`
* `latitude`
* `longitude`
* `location_formatted`
* `description`
* `requirements`
* `employment_type`
* `details_url`
* `service_url`
* `similar_jobs_url`
* `apply_url`
* `begin_date`
* `end_date`
* `posted_date`
* `posted_time`
* `relevancy`
* `state`
* `city`
* `zip`
* `can_be_quick_applied`
* `apply_requirements`
* `divison`
* `industry`
* `location_street_1`
* `relocation_options`
* `location_street_2`
* `display_job_id`
* `manages_others_string`
* `degree_required_code`
* `travel_required_code`
* `employment_type_code`
* `external_application?`
* `relocation_covered?`
* `manages_others?`
* `screener_apply?`
* `shared_job?`
* `can_be_quick_applied?`
* `has_questionnaire?`
* `find_company`

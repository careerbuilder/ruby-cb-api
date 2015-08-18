Version History
====
    * All Version bumps are required to update this file as well!!
----

* 17.4.0 Adding job search version 3 as additional call
* 17.3.0 Set `ENV['SIMULATE_AUTH_OUTAGE']` to true to throw a `Cb::ServiceUnavailableError` for all API calls.
* 17.2.0 Give back more information about the API caller for timings
* 17.1.0 Start sending timings to all observers for API calls
* 17.0.2 making sure we explicitly ask for version 1 of the consumer APIs
* 17.0.1 adding posted_time and company_did to job results
* 17.0.0 removed spot cms dependency
* 16.3.0 changed api error response to use join instead of to_s
* 16.2.2 change degree code to be degree which fixes compatibility problems
* 16.2.1 fix major or program in resume put. it was looking for the wrong value
* 16.2.0 Added support for work experience ID in resume put
* 16.1.0 Added support for handling a 401 unauthorized response. We should now raise specific UnauthorizedErrors.
* 16.0.0 Modifying the Resume model to reflect the changes made in the API (Removal of job title from salary and
        addition of id to work experience and work Experience Id to salary
* 15.1.0 Added resume post
* 15.0.3 Add desc to doc.rake so it shows in `rake -T`
* 15.0.2 Include the rake tasks in the gem
* 15.0.1 Add `cb:test` rake task for rspec independence on the build server
* 15.0.0 Removing old country_codes call and replacing it with new countries call
* 14.7.0 Adding desired job type data list
* 14.6.0 Adding language data-list as well as a refactor which will make the future
         data-list apis that are coming much easier.
* 14.5.0 Added education code api call for resume view edit
* 14.4.0 Added State list to the gem
* 14.3.1 Fixed missing response mapping
* 14.3.0 Added country codes api call
* 14.2.0 Added resume language codes api call
* 14.1.2 Added count limit to resume recommendations call
* 14.1.1 Added case for Job model "pay" when setting model properties
         so job search result pay field would be added to response as well
* 14.1.0 Adding custom error for Authentication Outages
* 14.0.1 Introduced a changelog (finally)
* 14.0.0 Rename location_code / zip to postal_code on the Cb::Models::User model to be more i18n friendly
* 13.0.1 This change is to turn off metadata parsing and raise exception if the api response does not contain metadata.
    * This means we can optionally control wether or not a specific API call expects metadata to come back   
* 13.0.0 Adds a new resume recommendations call and removes the old one *(BREAKING)*
    * https://github.com/cbdr/ruby-cb-api/pull/154/files

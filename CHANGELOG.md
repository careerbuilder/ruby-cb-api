Version History
====
    * All Version bumps are required to update this file as well!!
----
<<<<<<< HEAD
* 14.4.0 Adding HireInsider models and request objects
=======

* 14.5.0 Added education code api call for resume view edit
* 14.4.0 adding State list to the gem
>>>>>>> 6f95d0e9dbf7ad7d87c33d77b2aaa48c1d23f904
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

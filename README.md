First things first. You're going to need to get a developer key from Careerbuilder. You can obtain a key at http://api.careerbuilder.com/RequestDevKey.aspx.

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
There's a couple ways to go about conducting a job search.

Option 1:

    search = Cb.job_search_criteria.location('Atlanta, GA').radius(10).search()

Option 2:

    crit = Cb.job_search_criteria
    crit.location = 'Atlanta, GA'
    crit.radius = 10
    search = crit.search()

Either way, you will get back an array of CbJob.

    search.each do |job|
      puts job.title
      puts job.company_name
      puts job.instance_variables
    end

You will also get meta data regarding the search itself (helpful for pagination).

    puts search.cb_response.total_pages
    puts search.cb_response.total_count
    puts search.cb_response.errors # Hopefully this is nil! If it's not nil, it will be an array of error messages.

Coming Soon
================
The way that requests are handled is being completely redone. You will now only need to instantiate a single client class and pass it a request object.

You may now pass a block that will be executed before and after each API call. This will provide the same information that the Observer methods do.

    client = Cb::Client.new { |request_metadata| storage_device.add(request_metadata) }

Or just call it without the block if you don't care about an individual call's observer info

    client = Cb::Client.new

Pass it a request object, and you will receive the appropriate response object back

    request = Cb::Requests::Endpoint::CallName.new( { key1: 'value1', key2: 'value2' } )
    response = client.execute request

Currently, this workflow only works on the following endpoints:

* Anonymous Saved Search
* Application
* Application External
* Company
* User

Look here for future updates on this refactor!

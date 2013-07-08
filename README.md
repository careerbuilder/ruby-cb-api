First things first. You're going to need to get a developer key from Careerbuilder. You can obtain a key at http://api.careerbuilder.com/RequestDevKey.aspx.

Now that you have a key, lets get to the good stuff.

You can find an example rails site that uses the gem here:
https://github.com/cbdr/ruby-cb-api-demo

Configuration
================
Set your dev key, and any other configuration settings in a place that will run prior to your API calls.

    Cb.configure do |config|
      config.dev_key  	= 'your-dev-key-goes-here'
      config.time_out 	= 5
    end

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

    search.each |job| do
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
More documentation!

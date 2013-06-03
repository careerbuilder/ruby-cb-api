module Cb
	class CbUser
	    attr_accessor :user_status, :password, :email, :address_1, :address_2, :city, :state,
	                  :province, :postal_code, :zip, :country_code, :first_name,
	                  :last_name, :phone, :fax, :last_login, :created, :allow_partner_emails,
	                  :allow_newsletter_emails, :allow_email_from_headhunter, :domain, :registration_path, 
	                  :user_type, :gender, :birth_date, :cobrand_code, :resume_stats, :custom_values

	    def initialize(args = {})
			return if args.nil?

			@user_status                  = args['UserStatus'] || ''
			@password                     = ''
			@email              		  = args['Email'] || ''
			@address_1                    = args['Address1'] || ''
			@address_2                    = args['Address2'] || ''
			@city                         = args['City'] || ''
			@state                        = args['State'] || ''
			@province                     = args['Province'] || ''
			@postal_code                  = args['PostalCode'] || ''
			@zip                          = args['Zip'] || ''
			@country_code                 = args['CountryCode'] || ''
			@first_name                   = args['FirstName'] || ''
			@last_name                    = args['LastName'] || ''
			@phone                        = args['Phone'] || ''
			@fax                          = args['Fax'] || ''
			@last_login                   = args['LastLogin'] || ''
			@created                      = args['CreatedDT'] || ''
			@allow_partner_emails         = args['AllowPartnerEmails'] || ''
			@allow_newsletter_emails      = args['AllowNewsletterEmails'] || ''
			@allow_email_from_headhunter  = args['AllowEmailFromHeadHunter'] || ''
			@domain                       = args['Domain'] || ''
			@registration_path            = args['RegistrationPath'] || ''
			@user_type                    = args['UserType'] || ''
			@gender                       = args['Gender'] || ''
			@birth_date                   = args['BirthDate'] || ''
			@cobrand_code                 = args['CoBrandCode'] || ''
			@resume_stats                 = args['ResumeStats'] || ''
			@custom_values                = args['CustomValues'] || ''
	    end

	    def custom_value custom_value_key
	    	@custom_values['CustomValue'].each do |custom_value|
	    		return custom_value['Value'] if custom_value['Key'] == custom_value_key
	    	end
	    end
	end
end
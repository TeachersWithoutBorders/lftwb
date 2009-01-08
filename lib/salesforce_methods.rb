module SalesforceMethods
    
    # sync user data with salesforce
    def salesforce_sync

      sf_user = Contact.find(:first, :conditions => ['email = ?', self.email]) || Contact.new()
      sf_user.email = self.email || 'not specified'
      sf_user.remote_id__c = self.id 
      sf_user.remote_login__c = self.login
      sf_user.first_name = self.first_name || 'not specified'
      sf_user.last_name = self.last_name || 'not specified'
      sf_user.mailing_city = self.property('city') || 'not specified'
      sf_user.mailing_state = self.property('state') || 'not specified'
      sf_user.mailing_postal_code = self.property('zip') || 'not specified'
      sf_user.mailing_country = self.property('country') || 'not specified'
      sf_user.phone = self.property('phone') || 'not specified'
      sf_user.first_language__c = self.property('language') || 'not specified'
      sf_user.grade_level_experience__c = self.property('grade_level_experiences') || 'none'
      sf_user.why_joined__c = self.property('why_joined') || 'not specified'
      sf_user.additional_skills__c = self.property('skills') || 'not specified'
      sf_user.other_languages__c = self.property('other_languages') || 'none'
      sf_user.occupation__c = self.property('occupation') || 'not specified'
      sf_user.employer__c = '0' # self.organization || 'not specified'
      sf_user.record_type_id = '01270000000DgFe' # type 'Member'
      sf_user.account_id = GlobalConfig.salesforce_account_id
      sf_user.owner_id =  GlobalConfig.salesforce_owner_id
      sf_user.member__c = true
      sf_user.interest_areas__c = self.property('interests') || 'not specified'
      
#      sf_user.email = self.email || 'not specified'
#      sf_user.remote_id__c = self.id 
#      sf_user.remote_login__c = self.login
#      sf_user.first_name = self.first_name || 'not specified'
#      sf_user.last_name = self.last_name || 'not specified'
#      sf_user.mailing_city = self.city || 'not specified'
#      sf_user.mailing_state = self.state.name || 'not specified'
#      sf_user.mailing_postal_code = self.zip || 'not specified'
#      sf_user.mailing_country = self.country.name || 'not specified'
#      sf_user.phone = self.phone || 'not specified'
#      sf_user.first_language__c = self.language.nil? ? 'not specified' : self.language.english_name
#      if self.grade_level_experiences.length > 0
#        sf_user.grade_level_experience__c = self.grade_level_experiences.collect{|c| c.name}
#      end
#      sf_user.why_joined__c = self.why_joined || 'not specified'
#      sf_user.additional_skills__c = self.skills || 'not specified'
#      if self.languages.length > 0
#        sf_user.other_languages__c = self.languages.collect{|c| c.english_name}
#      end
#      sf_user.occupation__c = self.occupation || 'not specified'
#      sf_user.employer__c = '0' # self.organization || 'not specified'
#      sf_user.record_type_id = '01270000000DgFe' # type 'Member'
#      sf_user.account_id = GlobalConfig.salesforce_account_id
#      sf_user.owner_id =  GlobalConfig.salesforce_owner_id
#      sf_user.member__c = true
#      if self.interests.length > 0
#        sf_user.interest_areas__c = self.interests.collect{|c| c.name}
#      end

      # sf_user.deceased__c = 0
      # sf_user.newsletter__c = 1

      # for later
      # sf_user.twb_canada__c = sf_user.twb_canada__c || false
      
      # volunteer_interests__c = '' 
      #       description, 
      #       addressee__c, 
      #       mobile_phone, 
      #       grade_level_experience__c, 
      #       spouse_name__c, 
      #       household_links__c, 
      #       other_languages__c, 
      #       created_by_id, 
      #       occupation__c, 
      #       additional_skills__c, 
      #       title, 
      #       member__c, 
      #       country_coordinator__c, 
      #       deceased__c, 
      #       newsletter__c, 
      #       master_record_id, 
      #       interest_areas__c, 
      #       email, 
      #       phone, 
      #       last_activity_date, other_postal_code, mailing_state, last_modified_date, other_country, 
      #       giraffe_heroes__c, account_id, mailing_postal_code, reports_to_id, 
      #       contact_name_dashboard__c, volunteer_status__c, other_city, system_modstamp, 
      #       department, 
      #       twb_staff_member__c, created_date, do_not_mail__c, partner__c, age__c, professional_role__c, why_joined__c, salutation, name, remote_login__c, assignment__c, volunteer__c, birthdate, mailing_city, last
      #       _name, first_name, home_phone, board_member__c, other_state, twb_tools__c, employeeor_contractor__c, my_tec_c__c, if_so_rate_per_hour__c, is_deleted, do_not_call, record_type_id, other_street, lead_source, philanthropic_interest
      #       s__c, intern_status__c, map__c, mailing_country, owner_id, fax, last_cu_update_date, last_modified_by_id, past_member__c, marital_status__c, onen_household_id__c, mailing_street, head_of_household__c, has_opted_out_of_email, las
      #       t_cu_request_date, other_phone, 
      #       certified__c, employer__c, paid__c

      sf_user.save
    rescue Exception => err
      logger.error("Failed to sync with Salesforce: #{err.message}")
    end
end
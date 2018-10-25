class LeadController < ApplicationController

    def index    
    end

    def new_lead
        p = params["lead"].permit!
        puts "PARAMS = #{p}"
        file_attachment = p["file_attachment"] 
        p["file_attachment"] = file_attachment.read
        lead = Lead.new(p)
        lead.valid?
        p lead.errors
        lead.save!



        ZendeskAPI::Ticket.new($client, :id => 1, :priority => "normal") # doesn't actually send a request, must explicitly call #save! 
        ZendeskAPI::Ticket.create!($client, 
            :subject => "#{params['lead'][:full_name]} from #{params['lead'][:company_name]}",
            :comment => "The contact #{params['lead'][:full_name]} from company #{params['lead'][:company_name]} 
            can be reached at email #{params['lead'][:email]} and at phone #{params['lead'][:phone]} number. 
            #{params['lead'][:department]}' department has a project named #{params['lead'][:project_name]} 
            which would require contribution from Rocket Elevators.
            \n#{params['lead'][:project_description]}
            \nAttached Message: #{params['lead'][:message]}
            \nThe Contact uploaded an attachment",
            :submitter_id => 123,
            :priority => "normal",
            :type => "question",
            :tags => "leadrequest",
            :custom_fields => [
                {id: 360010305054, value: "#{params['lead'][:full_name]}"},
                {id: 360010235393, value: "#{params['lead'][:phone]}"},
                {id: 360010305074, value: "#{params['lead'][:email]}"},
                {id: 360010305094, value: "#{params['lead'][:company_name]}"},
                {id: 360010235553, value: "#{params['lead'][:project_name]}"},
                {id: 360010308814, value: "#{params['lead'][:project_description]}"},
                {id: 360010241293, value: "#{params['lead'][:department].downcase.include?("corporate") ? "corporate_services" : "residential_services"}"}
            ],
            
        )
    end
end

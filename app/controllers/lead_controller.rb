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
        ZendeskAPI::Ticket.new($client, :id => 1, :priority => "urgent") # doesn't actually send a request, must explicitly call #save! 
        ZendeskAPI::Ticket.create!($client, :subject => "#{params['lead'][:company_name]}", :comment => { :value => "You have received a new quote submission from #{params['lead'][:full_name]}\nEmail: #{params['lead'][:email]}\nPhone: #{params['lead'][:phone]}\nCompany Name: #{params['lead'][:company_name]}\nProject Name: #{params['lead'][:project_name]}\nProject Description: #{params['lead'][:project_description]}\nDepartment: #{params['lead'][:department]}\nMessage: #{params['lead'][:message]}\n" }, :submitter_id => 123, :priority => "urgent")
        lead.save!
    end



end
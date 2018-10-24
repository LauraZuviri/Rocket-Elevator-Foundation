class LeadController < ApplicationController

    def index    
    end

    def new_lead
        p = params["lead"].permit!
        puts "PARAMS = #{p}"
        file_attachment = p["file_attachment"] 
        #p["file_attachment"] = file_attachment.read
        lead = Lead.new(p)
        lead.valid?
        p lead.errors
        ZendeskAPI::Ticket.new($client, :id => 1, :priority => "normal") # doesn't actually send a request, must explicitly call #save! 
        ZendeskAPI::Ticket.create!($client, :subject => "#{params['lead'][:company_name]}", :comment => "#{params['lead'][:message]}", :submitter_id => 123, :priority => "normal", :type => "question", :group => "lead")
       
        lead.save!
    end



end
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
    end

end
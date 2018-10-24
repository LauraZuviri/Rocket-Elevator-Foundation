class LeadController < ApplicationController
    require 'sendgrid-ruby'
    include SendGrid

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

        data = JSON.parse("{
                \"personalizations\": [
                    {
                    \"to\": [
                        {
                    \"email\": \"#{lead.email}\"
                        }
                    ],
                    \"dynamic_template_data\": {
                        \"subject\": \"Confirmation\",
                        \"FullName\": \"#{lead.full_name}\",
                        \"ProjectName\": \"#{lead.project_name}\"
                        }
                    }
                ],
                \"from\": {
                    \"email\": \"adm@rocketelevators.ca\"
                },
                \"template_id\": \"d-a764a69415a54d3db616f1aab3e501a7\"
            }")
            sg = SendGrid::API.new(api_key: ENV['SENDGRID_KEY'])
            begin
                response = sg.client.mail._("send").post(request_body: data)
            rescue Exception => e
                puts e.message
            end
        

    end

end
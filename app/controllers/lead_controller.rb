class LeadController < ApplicationController
    require 'sendgrid-ruby'
    include SendGrid

    def index
        client = DropboxApi::Client.new("C8Eg7_xlTzAAAAAAAAAAMduh226EdjZy_X_pVqXkbOUenDBMOVpQwo0zhF9sr8bC")
        @result = client.list_folder "/Yann Doré"
        pp @result.entries
        @result.has_more?   
    end

    def new_lead
        p = params["lead"].permit!
        client = DropboxApi::Client.new('C8Eg7_xlTzAAAAAAAAAAMduh226EdjZy_X_pVqXkbOUenDBMOVpQwo0zhF9sr8bC')
        file_attachment = p("file_attachment") 
       original_file_name = file_attachment.original_filename 
       p["original_file_name"] = original_file_name
        # if file_attachment
        #     client.upload("/rocket_elevators/#{params["lead"]["full_name"]}/#{File.basename(original_file_name, '.*')}_#{Time.now.to_i}#{File.extname(original_file_name)}", file_attachment.read)
        # end

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
                    \"email\": \"rocketelevators@gmail.com\"
                },
                \"template_id\": \"d-a764a69415a54d3db616f1aab3e501a7\"
            }")
            sg = SendGrid::API.new(api_key: ENV['SENDGRID_KEY'])
            begin
                response = sg.client.mail._("send").post(request_body: data)
            rescue Exception => e
                puts e.message
            end
      
            if params['lead'][:file_attachment].blank? === false
                ticket = ZendeskAPI::Ticket.create!($client, 
                    :subject => "#{params['lead'][:full_name]} from #{params['lead'][:company_name]}",
                    :comment => "The contact #{params['lead'][:full_name]} from company #{params['lead'][:company_name]} 
                    can be reached at email #{params['lead'][:email]} and at phone #{params['lead'][:phone]} number. 
                    #{params['lead'][:department]}' department has a project named #{params['lead'][:project_name]} 
                    which would require contribution from Rocket Elevators.
                    \n#{params['lead'][:project_description]}
                    \nAttached Message: #{params['lead'][:message]}
                    \nThe contact uploaded an attachment",
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
                else
                    ticket = ZendeskAPI::Ticket.create!($client, 
                        :subject => "#{params['lead'][:full_name]} from #{params['lead'][:company_name]}",
                        :comment => "The contact #{params['lead'][:full_name]} from company #{params['lead'][:company_name]} 
                        can be reached at email #{params['lead'][:email]} and at phone #{params['lead'][:phone]} number. 
                        #{params['lead'][:department]}' department has a project named #{params['lead'][:project_name]} 
                        which would require contribution from Rocket Elevators.
                        \n#{params['lead'][:project_description]}
                        \nAttached Message: #{params['lead'][:message]}",
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
end
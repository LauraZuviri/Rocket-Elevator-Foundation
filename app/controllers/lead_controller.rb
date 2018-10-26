class LeadController < ApplicationController
    require 'sendgrid-ruby'
    include SendGrid

    def index
        client = DropboxApi::Client.new('C8Eg7_xlTzAAAAAAAAAAEsz6c89hSWEeULmvVUnlaCA0vo_Rk4D4k8DSghIWq6Vy')
        @result = client.list_folder "/Yann Doré"
        pp @result.entries
        @result.has_more?   
    end

    def new_lead
        client = DropboxApi::Client.new(ENV["DROPBOX_KEY"])
        p = params["lead"].permit!
        puts "PARAMS = #{p}"
        file_attachment = p.delete("file_attachment") 
        if file_attachment != nil
        original_file_name = file_attachment.original_filename
        client.upload("/#{params["lead"]["full_name"]}/#{File.basename(original_file_name, '.*')}_#{Time.now.to_i}#{File.extname(original_file_name)}", file_attachment)
        end

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
<<<<<<< HEAD
      
        ticket = ZendeskAPI::Ticket.new($client, :id => 1, :priority => "normal") 
        if file_attachment != nil
            original_file_name = file_attachment.original_filename
            ticket.comment.uploads << File.new("#{File.basename(original_file_name, '.*')}_#{Time.now.to_i}#{File.extname(original_file_name)}")
            end
        ticket.create!($client, 
=======
        

 

         lead = Lead.find(lead.id)
        unless lead.file_attachment.nil?
        
         lead.file_attachment = nil
         lead.save
        end


        # authenticator = DropboxApi::Authenticator.new("ub3wekvilx0yamm", "bonh62uwfvj6i9e")
        # #authenticator.authorize_url #=> "https://www.dropbox.com/..."
        

        # auth_bearer = authenticator.get_token('C8Eg7_xlTzAAAAAAAAAACi90qEv3rL4ufKVtzTaHDTpElmtbr3IK2P-YPbz6MfQT') #=> #<OAuth2::AccessToken ...>`
        # # auth_bearer.token #=> "VofXAX8D..."
        
        # client = DropboxApi::Client.new("ub3wekvilx0yamm")
        
        # result = client.list_folder "/sample_folder"
        # result.entries
        # result.has_more?




        ZendeskAPI::Ticket.new($client, :id => 1, :priority => "normal") # doesn't actually send a request, must explicitly call #save! 
        ZendeskAPI::Ticket.create!($client, 
>>>>>>> b5c3e3a5e36b8a9e74808e9809418d5eb6af01d4
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

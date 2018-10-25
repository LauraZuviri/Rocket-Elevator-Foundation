class LeadController < ApplicationController

    def index
         
        client = DropboxApi::Client.new('C8Eg7_xlTzAAAAAAAAAAEsz6c89hSWEeULmvVUnlaCA0vo_Rk4D4k8DSghIWq6Vy')
        
        @result = client.list_folder "/Yann Doré"
        pp @result.entries
        @result.has_more?   
       

    end

    def new_lead
        client = DropboxApi::Client.new('C8Eg7_xlTzAAAAAAAAAAEsz6c89hSWEeULmvVUnlaCA0vo_Rk4D4k8DSghIWq6Vy')
        p = params["lead"].permit!
        puts "PARAMS = #{p}"
        file_attachment = p.delete("file_attachment") 
        original_file_name = file_attachment.original_filename
        puts "FILE NAME = #{original_file_name}" 
        if file_attachment != nil
            file_attachment = file_attachment.read  
        end
        client.upload("/#{params["lead"]["full_name"]}/#{File.basename(original_file_name, '.*')}_#{Time.now.to_i}#{File.extname(original_file_name)}", file_attachment)
        lead = Lead.new(p)
        lead.valid?
        p lead.errors
        lead.save!

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

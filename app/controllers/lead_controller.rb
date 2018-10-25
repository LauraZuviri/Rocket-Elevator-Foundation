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


    end

end
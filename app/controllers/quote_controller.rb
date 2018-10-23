class QuoteController < ApplicationController




    def new_quote
        quote = Quote.new(params["quote"].permit!)
        ZendeskAPI::Ticket.new($client, :id => 1, :priority => "urgent") # doesn't actually send a request, must explicitly call #save! 
        ZendeskAPI::Ticket.create!($client, :subject => "#{params['quote'][:business_name]}'s quote", :comment => { :value => "You have received a new quote submission from #{params['quote'][:full_name]}\nNumber of floors: #{params['quote'][:nb_floors]}\nNumber of appartments: #{params['quote'][:nb_apt]}\nNumber of basements: #{params['quote'][:nb_base]}\nNumber of company: #{params['quote'][:nb_cies]}\nParking slots: #{params['quote'][:nb_parking]}\nNumber of elevator shafts: #{params['quote'][:nb_shaft]}\nNumber of corporations: #{params['quote'][:nb_corp]}\nNumber of persons: #{params['quote'][:nb_person]}\nRequested amount of elevators: #{params['quote'][:req_elev]}\nOption: #{params['quote'][:option]}\nNumber of elevators: #{params['quote'][:nb_elev]}\nPrice per elevator: #{params['quote'][:price_per_elev]}\nPrice for all elevators: #{params['quote'][:elev_total]}\nInstallation price: #{params['quote'][:cost_install]}\nTotal price: #{params['quote'][:total]}\nBusiness: #{params['quote'][:business_name]}\nContact Email: #{params['quote'][:email]}\n"}, :submitter_id => 123, :priority => "urgent")
        quote.save
        
    end

end

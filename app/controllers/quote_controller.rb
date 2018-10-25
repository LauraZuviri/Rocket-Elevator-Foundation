class QuoteController < ApplicationController



    def new_quote
        quote = Quote.new(params["quote"].permit!)
        quote.save

        if params['quote'][:quote_type] === "residential"
            subject = "Residential quote from #{params['quote'][:business_name]} by #{params['quote'][:full_name]}"
            tag = "residentialquoterequest"
            comment = "Residential quote from #{params['quote'][:business_name]} by #{params['quote'][:full_name]}
            \nEmail #{params['quote'][:email]}
            \nFrom #{params['quote'][:full_name]}
            \nCompany #{params['quote'][:business_name]}
            \nNumber of apartments #{params['quote'][:nb_apt]}
            \nNumber of floors #{params['quote'][:nb_floors]}
            \nNumber of basements #{params['quote'][:nb_base]}
            \nNumber of elevators #{params['quote'][:nb_elev]}
            \nQuality #{params['quote'][:option]}
            \nTotal price #{params['quote'][:total]}"
            content = [{id: 360010321233, value: "#{params['quote'][:quote_type]}"},
            {id: 360010305054, value: "#{params['quote'][:full_name]}"},
            {id: 360010305074, value: "#{params['quote'][:email]}"},
            {id: 360010305094, value: "#{params['quote'][:business_name]}"},
            {id: 360010359254, value: "#{params['quote'][:nb_apt]}"},
            {id: 360010359234, value: "#{params['quote'][:nb_floors]}"},
            {id: 360010359274, value: "#{params['quote'][:nb_base]}"},
            {id: 360010296153, value: "#{params['quote'][:nb_elev]}"},
            {id: 360010366094, value: "#{params['quote'][:option]}"},
            {id: 360010296393, value: "#{params['quote'][:total]}"}]

        elsif params['quote'][:quote_type] === "commercial"
            subject = "Commercial quote from #{params['quote'][:business_name]} by #{params['quote'][:full_name]}"
            tag = "commercialquoterequest"
            comment = "Commercial quote from #{params['quote'][:business_name]} by #{params['quote'][:full_name]}
            \nEmail #{params['quote'][:email]}
            \nFrom #{params['quote'][:full_name]}
            \nCompany #{params['quote'][:business_name]}
            \nNumber of apartments #{params['quote'][:nb_apt]}
            \nNumber of floors #{params['quote'][:nb_floors]}
            \nNumber of basements #{params['quote'][:nb_base]}
            \nNumber of companies #{params['quote'][:nb_cies]}
            \nNumber of parkings #{params['quote'][:nb_parking]}
            \nNumber of elevator shafts #{params['quote'][:nb_shaft]}
            \nNumber of elevators #{params['quote'][:nb_elev]}
            \nQuality #{params['quote'][:option]}
            \nTotal price #{params['quote'][:total]}"
            content = [{id: 360010321233, value: "#{params['quote'][:quote_type]}"},
            {id: 360010305054, value: "#{params['quote'][:full_name]}"},
            {id: 360010305074, value: "#{params['quote'][:email]}"},
            {id: 360010305094, value: "#{params['quote'][:business_name]}"},
            {id: 360010359234, value: "#{params['quote'][:nb_floors]}"},
            {id: 360010359274, value: "#{params['quote'][:nb_base]}"},
            {id: 360010361394, value: "#{params['quote'][:nb_cies]}"},
            {id: 360010361374, value: "#{params['quote'][:nb_parking]}"},
            {id: 360010361214, value: "#{params['quote'][:nb_shaft]}"},
            {id: 360010296153, value: "#{params['quote'][:nb_elev]}"},
            {id: 360010366094, value: "#{params['quote'][:option]}"},
            {id: 360010296393, value: "#{params['quote'][:total]}"}]

        elsif params['quote'][:quote_type] === "corporate"
            subject = "Corporate quote from #{params['quote'][:business_name]} by #{params['quote'][:full_name]}"
            tag = "corporatequoterequest"
            comment = "Corporate quote from #{params['quote'][:business_name]} by #{params['quote'][:full_name]}
            \nEmail #{params['quote'][:email]}
            \nFrom #{params['quote'][:full_name]}
            \nCompany #{params['quote'][:business_name]}
            \nNumber of apartments #{params['quote'][:nb_apt]}
            \nNumber of floors #{params['quote'][:nb_floors]}
            \nNumber of basements #{params['quote'][:nb_base]}
            \nNumber of corporations #{params['quote'][:nb_corp]}
            \nNumber of parkings #{params['quote'][:nb_parking]}
            \nNumber of persons per floor #{params['quote'][:nb_person]}
            \nNumber of elevators #{params['quote'][:nb_elev]}
            \nQuality #{params['quote'][:option]}
            \nTotal price #{params['quote'][:total]}"
            content = [{id: 360010321233, value: "#{params['quote'][:quote_type]}"},
            {id: 360010305054, value: "#{params['quote'][:full_name]}"},
            {id: 360010305074, value: "#{params['quote'][:email]}"},
            {id: 360010305094, value: "#{params['quote'][:business_name]}"},
            {id: 360010359234, value: "#{params['quote'][:nb_floors]}"},
            {id: 360010359274, value: "#{params['quote'][:nb_base]}"},
            {id: 360010322093, value: "#{params['quote'][:nb_corp]}"},
            {id: 360010361374, value: "#{params['quote'][:nb_parking]}"},
            {id: 360010322113, value: "#{params['quote'][:nb_person]}"},  
            {id: 360010296153, value: "#{params['quote'][:nb_elev]}"},
            {id: 360010366094, value: "#{params['quote'][:option]}"},
            {id: 360010296393, value: "#{params['quote'][:total]}"}]

        elsif params['quote'][:quote_type] === "hybrid"
            subject = "Hybrid quote from #{params['quote'][:business_name]} by #{params['quote'][:full_name]}"
            tag = "hybridquoterequest"
            comment = "Hybrid quote from #{params['quote'][:business_name]} by #{params['quote'][:full_name]}
            \nEmail #{params['quote'][:email]}
            \nFrom #{params['quote'][:full_name]}
            \nCompany #{params['quote'][:business_name]}
            \nNumber of apartments #{params['quote'][:nb_apt]}
            \nNumber of floors #{params['quote'][:nb_floors]}
            \nNumber of basements #{params['quote'][:nb_base]}
            \nNumber of companies #{params['quote'][:nb_cies]}
            \nNumber of parkings #{params['quote'][:nb_parking]}
            \nNumber of person per floor #{params['quote'][:nb_person]}
            \nNumber of elevators #{params['quote'][:nb_elev]}
            \nQuality #{params['quote'][:option]}
            \nTotal price #{params['quote'][:total]}"
            content = [{id: 360010321233, value: "#{params['quote'][:quote_type]}"},
            {id: 360010305054, value: "#{params['quote'][:full_name]}"},
            {id: 360010305074, value: "#{params['quote'][:email]}"},
            {id: 360010305094, value: "#{params['quote'][:business_name]}"},
            {id: 360010359234, value: "#{params['quote'][:nb_floors]}"},
            {id: 360010359274, value: "#{params['quote'][:nb_base]}"},
            {id: 360010361394, value: "#{params['quote'][:nb_cies]}"},
            {id: 360010361374, value: "#{params['quote'][:nb_parking]}"},
            {id: 360010322113, value: "#{params['quote'][:nb_person]}"},
            {id: 360010296153, value: "#{params['quote'][:nb_elev]}"},
            {id: 360010366094, value: "#{params['quote'][:option]}"},
            {id: 360010296393, value: "#{params['quote'][:total]}"}]
        end


        ZendeskAPI::Ticket.new($client) # doesn't actually send a request, must explicitly call #save! 
        ZendeskAPI::Ticket.create!($client, 
            :subject => subject, 
            :comment => comment,
            :submitter_id => 123,
            :priority => "normal",
            :type => "task",
            :tags => tag,
            :custom_fields => content)

    end

end

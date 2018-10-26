require "net/http"
require "net/https"

class MapsController < ApplicationController
    before_action :authenticate_user!
    
    def location

    buildings = Building.all
    @location_list = []
    buildings.each do |building|

    begin 
        #get info in database
        @for_google = building.address.name

        test = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @for_google + "&key=#{ENV["GOOGLE_KEY"]}"
        uri = URI(test)

    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        request = Net::HTTP::Get.new uri
        rep = http.request(request) # Net::HTTPResponse object 
        @response = JSON.parse(rep.body)
    end

        #creation of variables
    address = building.address.name
    bat = building.batteries.count
    bat_ids = building.battery_ids
    col = Column.where(battery_id: bat_ids).count
    col_ids = Column.where(battery_id: building.battery_ids).ids
    elev = Elevator.where(column_id: col_ids).count

    bd_floor = building.building_details.where("UPPER(information_key) like '%FLOOR%'").first
    floor = bd_floor ? bd_floor.value : "Not available"

    #Extraction of Latitude and Longitude
    lat = @response["results"][0]["geometry"]["location"]["lat"]
    lng = @response["results"][0]["geometry"]["location"]["lng"]
    #Creation of an array to send the information
    @location_list << {name: building.name,
    lat: lat,
    lng: lng,
    batteries: bat, 
    columns: col,
    elevators: elev,
    address: address,
    customer: building.customer.name,
    technician: building.technician_full_name,
    floors: floor}


    rescue Exception => e
    end
end
end
end

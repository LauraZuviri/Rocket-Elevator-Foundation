class Elevator < ApplicationRecord
  require 'twilio-ruby'
  require 'slack-ruby-client'
  validate :elevator_validate
  belongs_to :column
  def model_enum
    [['Standard', 0],['Premium',1],['Excelium',2]]
  end
  def status_enum
    [['Active', 'Active'],['Inactive', 'Inactive'], ['Intervention', 'Intervention'], ['Alarm', 'Alarm']]
  end


  def building_type_enum
    [['Residential', 0],['Commercial',1],['Corporate',2],['Hybrid',3]]
  end

def elevator_validate
  if self.status_changed? then
    @client = Twilio::REST::Client.new(ENV["account_sid"], ENV["auth_token"])
    message = @client.messages
      .create(
        from: '+13473703502',
        to: "+#{self.column.battery.building.technician_phone}",
       body: "The status of Elevator ##{self.id} from building ##{self.column.battery.building.id} state has changed from #{self.changes['status'][0]} to #{self.status} at #{self.updated_at}"
       )
        Slack.configure do |config|
         config.token = ENV['SLACK_API_TOKEN']
       end
       sclient = Slack::Web::Client.new
       sclient.chat_postMessage(channel: 'elevator_operations', text: "The status of Elevator ##{self.id} from building ##{self.column.battery.building.id} state has changed from #{self.changes['status'][0]} to #{self.status} at #{self.updated_at}", as_user: false)
      end
end
end

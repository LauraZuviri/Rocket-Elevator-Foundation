class Column < ApplicationRecord
  require 'slack-ruby-client'
 validate :column_validate
  def building_type_enum
    [['Residential', 0],['Commercial',1],['Corporate',2],['Hybrid',3]]
  end
   def status_enum
        [['Active', 'Active'],['Inactive', 'Inactive'],['Alarm', 'Alarm'], ['Intervention', 'Intervention']]
    end
  
    def column_validate
      if self.status_changed? then
      Slack.configure do |config|
        config.token = ENV['SLACK_API_TOKEN']
      end
      sclient = Slack::Web::Client.new
      sclient.chat_postMessage(channel: 'elevator_operations', text: "The status of Elevator ##{self.id} from building ##{self.battery.building.id} state has changed from #{self.changes['status'][0]} to #{self.status} at #{self.updated_at}", as_user: false)
    end
    end

  
  belongs_to :battery
  has_many :elevators
  rails_admin do
    edit do
      exclude_fields :elevator
    end
  end
end


class Customer < ApplicationRecord  
  belongs_to :user
  belongs_to :address
  has_many :buildings
  belongs_to :lead
after_save :dropbox

  rails_admin do
    edit do
      exclude_fields :buildings
    end
  end
  def name
    "#{self.business_name}"
  end
  def dropbox
    puts "dropbox"
    client = DropboxApi::Client.new('C8Eg7_xlTzAAAAAAAAAAMduh226EdjZy_X_pVqXkbOUenDBMOVpQwo0zhF9sr8bC')
    if self.lead and self.lead.file_attachment
      puts "A"
      client.upload("/rocket_elevators/#{self.lead.full_name}/#{File.basename(self.lead.original_file_name, '.*')}_#{Time.now.to_i}#{File.extname(self.lead.original_file_name)}", self.lead.file_attachment)
  end
end
end

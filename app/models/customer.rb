class Customer < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :buildings
  has_one :lead
  rails_admin do
    edit do
      exclude_fields :buildings
    end
  end
  def name
    "#{self.business_name}"
  end
end

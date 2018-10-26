require 'dropbox_api'
class Lead < ApplicationRecord 
  has_one :customer
end

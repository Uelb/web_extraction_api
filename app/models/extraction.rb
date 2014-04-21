class Extraction < ActiveRecord::Base
  validates_presence_of :user_id, :website_id
  belongs_to :user
  belongs_to :website
end

class Extraction < ActiveRecord::Base
  validates_presence_of :user, :website
  belongs_to :user
  belongs_to :website, touch: true
  has_many :labels, dependent: :destroy


  def generate_items_links
    labels.containers.each do |container|
      
    end
  end
end

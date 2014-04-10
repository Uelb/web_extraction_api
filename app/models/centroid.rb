class Centroid < ActiveRecord::Base
  belongs_to :label, touch: true
  has_many :items
  validates_presence_of :label
end

class Centroid < ActiveRecord::Base
  belongs_to :website, touch: true
  has_many :items
  validates_uniqueness_of :label
end

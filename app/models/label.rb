class Label < ActiveRecord::Base
  has_many :centroids, dependent: :destroy
  belongs_to :website, touch: true
  validates_presence_of :website
  has_many :items, dependent: :destroy


  def to_param
    value
  end

end

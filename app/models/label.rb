class Label < ActiveRecord::Base
  has_many :centroids, dependent: :destroy
  belongs_to :extraction, touch: true
  validates_presence_of :extraction
  has_many :items, dependent: :destroy

  def website
    self.extraction.website
  end

  def to_param
    value
  end

end

class Website < ActiveRecord::Base
  has_many :centroids
  validates_uniqueness_of :url
  validates_presence_of :url
  after_create :create_json_folder

  private
  def create_json_folder
    `mkdir #{Rails.root + 'public/jsons' + self.url}`
  end
end

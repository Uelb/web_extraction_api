class Statistic < ActiveRecord::Base
  belongs_to :extraction
  has_one :website, through: :extraction
  has_many :labels, through: :extraction
end

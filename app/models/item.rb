require 'csv'
class Item < ActiveRecord::Base
  belongs_to :label, touch: true
  validates :value, uniqueness: {scope: :label_id}, presence: true
  before_validation :format_item

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end
  private
  def format_item
    self.value = self.value.strip.squeeze.squeeze("\n")
  end
end

require 'csv'
class Item < ActiveRecord::Base
  belongs_to :label, touch: true
  has_one :extraction, through: :label
  has_one :website, through: :extraction
  has_many :associated_labels, through: :extraction, source: :labels
  validates :value, uniqueness: {scope: :label_id}, presence: true
  before_validation :format_item
  belongs_to :parent, class_name: "Item"
  has_many :children, class_name: "Item", foreign_key: :parent_id
  belongs_to :centroid, dependent: :destroy

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def find_parent
    possible_parents = self.associated_labels.containers.includes(items: :centroid).map(&:items).flatten.map(&:centroid)
    container = self.centroid.find_container possible_parents
    container.item
  end

  def find_children
    possible_children = self.associated_labels.where(container: false).includes(items: :centroid).map(&:items).flatten.map(&:centroid)
    p possible_children
    children = self.centroid.find_contained_centroids possible_children
    children.map &:item
  end

  private
  def format_item
    self.value = self.value.strip.squeeze(" ").squeeze("\n")
  end
end

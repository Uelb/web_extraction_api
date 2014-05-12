class Centroid < ActiveRecord::Base
  belongs_to :label, touch: true
  validates_presence_of :label

  def self.create_from_array centroid
    centroid_array = centroid[:centroid]
    Centroid.where(
      color: centroid_array[0],
      background_color: centroid_array[1],
      width: centroid_array[2],
      height: centroid_array[3],
      text_decoration: centroid_array[4],
      font_style: centroid_array[5],
      left_alignment: centroid_array[6],
      top_alignment: centroid_array[7],
      z_index: centroid_array[8],
      level: centroid[:depth]
    ).first_or_create
  end 
end

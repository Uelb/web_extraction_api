class Centroid < ActiveRecord::Base
  belongs_to :label, touch: true
  has_one :item

  def self.create_from_array centroid
    centroid_array = centroid[:centroid]
    result = Centroid.where(
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

  def find_container possible_containers
    # A possible container visually include his child, so we compare the centroids to find it
    parents = possible_containers.select do |possible_container|
      compare_nodes possible_container, self
    end
    return parents.first if parents.size == 1
    parents = parents.sort_by do |parent|
      (parent.left_alignment - self.left_alignment).abs + (parent.top_alignment - self.top_alignment).abs
    end
    return parents.first
  end

  def compare_nodes parent, possible_children
    a = parent
    b = possible_children
    a.left_alignment <= b.left_alignment && 
      a.top_alignment <= b.top_alignment &&
      a.width >= b.width && 
      a.height >= b.height
  end
end

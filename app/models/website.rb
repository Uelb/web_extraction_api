class Website < ActiveRecord::Base
  has_many :labels, dependent: :destroy
  validates_uniqueness_of :url
  validates_presence_of :url
  after_save :update_items
  belongs_to :user

  def self.parse html_string
    html_doc = Nokogiri::HTML html_string
    body = html_doc.at_css "body"
    head = html_doc.at_css "head"
    return head, body
  end

  def self.get_html_from_node_script url, weights=nil
    bash_code = "cd #{ENV['WEB_EXTRACTION_DIR']}; node phantom.js \"#{url}\""
    bash_code += " \"#{weights.to_json}\"" if weights
    html = `#{bash_code}`
  end

  def self.update_items
    `cd #{ENV['WEB_EXTRACTION_DIR']}; node result.js`
  end

  private
  def update_items
    Website.update_items
  end
end

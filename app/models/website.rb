class Website < ActiveRecord::Base
  has_many :extractions, dependent: :destroy
  has_many :labels, dependent: :destroy
  validates_uniqueness_of :url
  validates_presence_of :url
  has_many :users, through: :extractions

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
end

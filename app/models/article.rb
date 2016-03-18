class Article < ActiveRecord::Base
  validates :title, presence:true
  validates :body, presence:true, :length => { :minimum => 10 }
  belongs_to :author
  has_many :comments, :dependent => :destroy
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings, :dependent => :destroy

  has_attached_file :image, styles: { large:"1215x600>" , medium: "600x450>", thumb: "45x45>", small: "200x112>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

def tag_list
  self.tags.collect do |tag|
    tag.name
  end.join(", ")
end

def tag_list=(tags_string)
  tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
  new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
  self.tags = new_or_found_tags
end

end
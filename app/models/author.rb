class Author < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :author_pic, styles: { medium: "330x300>", thumb: "150x112>", small: "45x45" }, :default_url => "/assets/missing_avatar.jpg"
  validates_attachment_content_type :author_pic, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  has_many :comments, :dependent => :destroy
  has_many :articles, :dependent => :destroy

  validates :username, presence:true
end

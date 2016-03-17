class Comment < ActiveRecord::Base
  belongs_to :author
  belongs_to :article
  
  validates :body, :presence => true

end

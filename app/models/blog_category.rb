class BlogCategory < ActiveRecord::Base
	belongs_to :article
	belongs_to :master_category

searchable do

	integer :article_id
end


end

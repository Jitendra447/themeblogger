class MasterCategory < ActiveRecord::Base
	has_many :blog_categories
    
searchable do
text :name

end
end

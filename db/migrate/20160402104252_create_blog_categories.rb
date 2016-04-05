class CreateBlogCategories < ActiveRecord::Migration
  def change
    create_table :blog_categories do |t|
        t.references :article, index: true, foreign_key: true
        t.references :master_category, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end

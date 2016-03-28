class ChangeArticleBodyType < ActiveRecord::Migration
  def change
  	change_column :articles, :body, :text, limit: 4294967295
  end
end

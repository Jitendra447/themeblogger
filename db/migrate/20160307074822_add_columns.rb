class AddColumns < ActiveRecord::Migration
  def change
  	add_column :authors, :username, :string
  
  end
end

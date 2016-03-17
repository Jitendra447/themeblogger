class AddAttachmentAuthorPicToAuthors < ActiveRecord::Migration
  def self.up
    change_table :authors do |t|
      t.attachment :author_pic
    end
  end

  def self.down
    remove_attachment :authors, :author_pic
  end
end

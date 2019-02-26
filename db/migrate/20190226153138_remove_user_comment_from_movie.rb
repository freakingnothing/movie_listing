class RemoveUserCommentFromMovie < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :user_comment
  end
end

class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :rus_title
      t.string :original_title
      t.string :release_year
      t.string :rating
      t.string :genre
      t.string :url
      t.text :user_comment

      t.timestamps
    end
  end
end

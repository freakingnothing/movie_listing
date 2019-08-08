class AddSourceToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :source, :string
  end
end

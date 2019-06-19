class AddCountryToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :country, :string
  end
end

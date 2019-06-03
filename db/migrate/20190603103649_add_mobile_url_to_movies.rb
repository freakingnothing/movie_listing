class AddMobileUrlToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :mobile_url, :string
  end
end

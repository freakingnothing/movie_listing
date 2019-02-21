class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.belongs_to :list, foreign_key: true
      t.belongs_to :movie, foreign_key: true

      t.timestamps
    end
  end
end

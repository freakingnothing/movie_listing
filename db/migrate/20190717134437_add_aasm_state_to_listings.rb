class AddAasmStateToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :aasm_state, :string
  end
end

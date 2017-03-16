class AddMasterImageToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :master_image, :string
  end
end

class AddVisionIdentityToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :vision_identity, :string
  end
end

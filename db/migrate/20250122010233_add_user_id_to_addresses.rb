class AddUserIdToAddresses < ActiveRecord::Migration[7.2]
  def change
    add_column :addresses, :user_id, :integer
  end
end

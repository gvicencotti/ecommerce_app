class AddZipToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :zip, :string
  end
end

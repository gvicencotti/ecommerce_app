class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :cep
      t.string :street
      t.string :neighborhood
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end

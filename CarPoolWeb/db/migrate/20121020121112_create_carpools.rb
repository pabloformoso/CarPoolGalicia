class CreateCarpools < ActiveRecord::Migration
  def change
    create_table :carpools do |t|
      t.string :start_address
      t.string :destination_address
      t.datetime :departure
      t.references :driver
      t.integer :seats

      t.timestamps
    end
    add_index :carpools, :driver_id
  end
end

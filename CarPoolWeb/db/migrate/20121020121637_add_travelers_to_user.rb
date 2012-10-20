class AddTravelersToUser < ActiveRecord::Migration
  def change
    
    create_table :carpools_users, :id => false do |t|
      t.references :carpool
      t.references :user
    end
    
    add_index :carpools_users, [:carpool_id, :user_id]
    add_index :carpools_users, [:user_id, :carpool_id]
    
    add_column :users, :column_name, :string
  end
end
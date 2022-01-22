class AddCiToUsers < ActiveRecord::Migration[6.1]
  def change    
    add_column :users, :identification, :string
    add_column :users, :alergie, :string
    add_column :users, :contact_name, :string
    add_column :users, :contact_phone, :string
    add_column :users, :card_from, :datetime
    add_column :users, :card_to, :datetime
    add_column :users, :blood_type, :string
  end
end

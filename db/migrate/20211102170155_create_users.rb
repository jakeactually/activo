class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :code
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :company
      t.string :email
      t.string :phone
      t.string :position
      t.string :website
      t.string :role
      t.string :password

      t.timestamps
    end
  end
end

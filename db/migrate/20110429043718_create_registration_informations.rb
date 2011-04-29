class CreateRegistrationInformations < ActiveRecord::Migration
  def self.up
    create_table :registration_informations do |t|
      t.string :name
      t.string :password
      t.string :email
      t.integer :age
      t.string :phone
      t.string :description
      t.string :anti_bot_check

      t.timestamps
    end
  end

  def self.down
    drop_table :registration_informations
  end
end

class CreateLogins < ActiveRecord::Migration
  def self.up
    create_table :logins do |t|
      t.string :name, :limit => 32, :null => false
	  t.string :password
	  t.string :fname
	  t.string :lname
      t.string :phnumber
      t.string :email
	  t.timestamps
    end
    add_index :logins, :name, :unique => true
  end

  def self.down
    drop_table :logins
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :username
  		t.string :password_digest
  		t.integer :bamboo_shoots, :default => 5
  		t.integer :fish, :default => 5
  		t.integer :fruits, :default => 5
  		t.integer :grass, :default => 5
  		t.integer :meat, :default => 5
  	end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :username
  		t.string :password_digest
  		t.integer :bamboo_shoots
  		t.integer :fish
  		t.integer :fruits
  		t.integer :grass
  		t.integer :meat
  	end
  end
end

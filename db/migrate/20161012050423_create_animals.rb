class CreateAnimals < ActiveRecord::Migration
  def change
  	create_table :animals do |t|
  		t.string :name
  		t.string :species
  		t.text :description
  		t.integer :appetite, :default => 10
  		t.integer :happiness, :default => 0
  		t.integer :user_id
  	end
  end
end

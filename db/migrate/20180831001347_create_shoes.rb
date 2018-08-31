class CreateShoes < ActiveRecord::Migration
  def change
    create_table :shoes do |t|
      t.string :name
      t.string :manufacturer
      t.string :description
      t.integer :cost
      t.string :color
  end
end

class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.integer :zip
      t.boolean :kid_menu
      t.boolean :high_chairs
      t.boolean :boosters
      t.boolean :approve_kids
      t.boolean :changing_table
      t.integer :score
      t.string :noise_level

      t.timestamps
    end
  end
end

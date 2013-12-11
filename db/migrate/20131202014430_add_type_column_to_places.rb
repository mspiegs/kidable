class AddTypeColumnToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :type, :string
  end
end

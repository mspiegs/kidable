class ChangeNameOfTypeColumnInPlaces < ActiveRecord::Migration
  def change
  	rename_column :places, :type, :place_type
  end
end

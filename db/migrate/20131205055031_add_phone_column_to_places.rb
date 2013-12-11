class AddPhoneColumnToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :phone, :string
  end
end

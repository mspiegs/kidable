class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :place_id
      t.string :comment_title

      t.timestamps
    end
  end
end

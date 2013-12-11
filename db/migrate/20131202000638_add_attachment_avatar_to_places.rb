class AddAttachmentAvatarToPlaces < ActiveRecord::Migration
  def self.up
    change_table :places do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :places, :avatar
  end
end

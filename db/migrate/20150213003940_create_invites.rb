class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.references :user, index: true
      t.references :invitee, index: true

      t.timestamps
    end
  end
end

class CreateMembership < ActiveRecord::Migration[8.0]
  def change
    create_table :memberships do |t|
      t.references :organization
      t.references :user
      t.timestamps
    end
  end
end

class AddOrgReferenceToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :current_organization_id, :integer, null: true
  end
end

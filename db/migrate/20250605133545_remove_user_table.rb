class RemoveUserTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :player_matches
    drop_table :users
  end
end

class DeleteVotes < ActiveRecord::Migration[5.0]
  def change
    drop_table :votes
  end
end

class AddVotesToMocks < ActiveRecord::Migration[5.1]
  def self.up
    create_table :bolds do |t|

      t.references :votable, :polymorphic => true
      t.references :voter, :polymorphic => true

      t.boolean :vote_flag
      t.string :vote_scope
      t.integer :vote_weight

      t.timestamps
    end

    add_index :bolds, [:voter_id, :voter_type, :vote_scope]
    add_index :bolds, [:votable_id, :votable_type, :vote_scope]
  end

  def self.down
    drop_table :bolds
  end
end

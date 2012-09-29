class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.integer :number
      t.string :owner
      t.string :repo
      t.integer :event_id

      t.timestamps
    end
  end
end

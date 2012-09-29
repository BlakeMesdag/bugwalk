class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.timestamp :starts_at
      t.timestamp :ends_at

      t.timestamps
    end
  end
end

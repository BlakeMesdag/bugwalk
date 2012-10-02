class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :bio
      t.boolean :is_mentor, :default => false

      t.timestamps
    end
  end
end

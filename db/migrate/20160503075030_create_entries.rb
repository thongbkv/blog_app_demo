class CreateEntries < ActiveRecord::Migration
  def change
  	drop_table :entries

    create_table :entries do |t|
      t.text :body
      t.text :title
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :entries, [:user_id, :created_at]
  end
end

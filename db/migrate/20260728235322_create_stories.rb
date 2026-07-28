class CreateStories < ActiveRecord::Migration[8.1]
  def change
    create_table :stories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :status, null: false, default: 0
      t.string :cover_url

      t.timestamps
    end

    add_index :stories, :status
  end
end

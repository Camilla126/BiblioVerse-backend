class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.string :genre
      t.string :cover_url
      t.text :synopsis
      t.datetime :published_at

      t.timestamps
    end

    add_index :books, :title
    add_index :books, :genre
  end
end

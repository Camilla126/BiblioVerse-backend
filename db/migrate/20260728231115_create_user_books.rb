class CreateUserBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :user_books do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.integer :current_page, null: false, default: 0
      t.integer :total_pages

      t.timestamps
    end

    add_index :user_books, [ :user_id, :book_id ], unique: true
    add_index :user_books, :status
  end
end

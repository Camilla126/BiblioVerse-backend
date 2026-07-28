class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: true, foreign_key: true
      t.integer :kind, null: false
      t.text :content, null: false

      t.timestamps
    end

    add_index :posts, :kind
    add_index :posts, :created_at
  end
end

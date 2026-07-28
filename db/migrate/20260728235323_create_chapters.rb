class CreateChapters < ActiveRecord::Migration[8.1]
  def change
    create_table :chapters do |t|
      t.references :story, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.integer :position, null: false, default: 0
      t.datetime :published_at

      t.timestamps
    end

    add_index :chapters, [ :story_id, :position ]
  end
end

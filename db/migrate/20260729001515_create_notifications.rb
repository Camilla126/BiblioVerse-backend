class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :actor, null: true, foreign_key: { to_table: :users }
      t.integer :kind, null: false
      t.boolean :read, null: false, default: false
      t.jsonb :payload, null: false, default: {}

      t.timestamps
    end

    add_index :notifications, [ :user_id, :read ]
    add_index :notifications, :created_at
  end
end

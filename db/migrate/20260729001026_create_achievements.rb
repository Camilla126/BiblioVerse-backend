class CreateAchievements < ActiveRecord::Migration[8.1]
  def change
    create_table :achievements do |t|
      t.string :name, null: false
      t.string :description
      t.string :icon

      t.timestamps
    end

    add_index :achievements, :name, unique: true
  end
end

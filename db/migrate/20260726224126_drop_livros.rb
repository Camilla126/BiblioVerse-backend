class DropLivros < ActiveRecord::Migration[8.1]
  def up
    drop_table :livros, if_exists: true
  end

  def down
    create_table :livros do |t|
      t.string :titulo
      t.string :autor
      t.timestamps
    end
  end
end

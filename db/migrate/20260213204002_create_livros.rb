class CreateLivros < ActiveRecord::Migration[8.1]
  def change
    create_table :livros do |t|
      t.string :titulo
      t.string :autor

      t.timestamps
    end
  end
end

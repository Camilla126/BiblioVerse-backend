class AddProfileFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :handle, :string
    add_column :users, :bio, :text
    add_column :users, :location, :string
    add_column :users, :website, :string
    add_column :users, :avatar_url, :string
    add_column :users, :cover_url, :string

    add_index :users, :handle, unique: true
  end
end

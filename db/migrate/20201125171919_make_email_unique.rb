class MakeEmailUnique < ActiveRecord::Migration[6.0]
  def up
    add_index :users, :email, unique: true unless index_exists?(:users, :email)
  end

  def down 
    remove_index :users, :email if index_exists?(:users, :email)
  end
end

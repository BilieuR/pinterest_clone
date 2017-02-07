class AddUserIdToPins < ActiveRecord::Migration[5.0]
  def change
    add_reference :pins, :user, foreign_key: true, index: true
  end
end

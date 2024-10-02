class AddUserToTodos < ActiveRecord::Migration[6.1]
  def change
    add_reference :todos, :user, null: true, foreign_key: true
  end
end

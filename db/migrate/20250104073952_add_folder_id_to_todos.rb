class AddFolderIdToTodos < ActiveRecord::Migration[6.1]
  def change
    add_reference :todos, :folder, foreign_key: true
  end
end

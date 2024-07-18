class AddDescriptionToTodos < ActiveRecord::Migration[6.1]
  def change
    add_column :todos, :description, :string
  end
end

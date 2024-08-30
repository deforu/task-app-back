class AddFieldsToTodos < ActiveRecord::Migration[6.1]
  def change
    add_column :todos, :due_date, :date, null: false, default: -> { 'CURRENT_DATE' }
    add_column :todos, :is_important, :boolean, null: false, default: false
    
    unless column_exists?(:todos, :completed)
      add_column :todos, :completed, :boolean, null: false, default: false
    end
  end
end
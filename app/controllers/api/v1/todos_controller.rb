class Api::V1::TodosController < ApplicationController
  def index
    todos = Todo.order(created_at: :asc)
    render json: { status: 200, todos: todos }
    # render json: { message: "Hello World!"} # 動作確認用のテストAPI
  end
  
  def create
    todo = Todo.new(todo_params)
    
    if todo.save
      render json: { status: 200, todo: todo }
    else
      render json: { status: 500, message: "Todoの作成に失敗しました", errors: todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    todo = Todo.find(params[:id])

    if todo.destroy
      render json: { status: 200, todo: todo }
    else
      render json: { status: 500, message: "Todoの削除に失敗しました" }
    end
  end
  
  def update
    todo = Todo.find(params[:id])

    if todo.update(todo_params)
      render json: { status: 200, todo: todo }
    else
      render json: { status: 500, message: "Todoの更新に失敗しました", errors: todo.errors.full_messages }
    end
  end

  def show
    todo = Todo.find(params[:id])
    render json: { status: 200, todo: todo }
  rescue ActiveRecord::RecordNotFound
    render json: { status: 404, message: "Todoが見つかりません" }
  end

  def important
    todos = Todo.where(is_important: true)
    render json: { status: 200, todos: todos }
  end

  def today
    todos = Todo.where(due_date: Date.today)
    render json: { status: 200, todos: todos }
  end

  def completed
    todos = Todo.where(completed: true)
    render json: { status: 200, todos: todos }
  end

  private
  def todo_params
    params.require(:todo).permit(:title, :completed, :due_date, :is_important)
  end
end
class Api::V1::TodosController < ApplicationController
  # ログインしていないユーザーはアクセスできないようにする
  before_action :authenticate_api_v1_user!

  # フォルダに属するTodoのみ取得する場合に必要
  before_action :set_folder, only: [:index, :create]

  def index
    if @folder
      # 特定のフォルダ内のTodoを取得
      todos = @folder.todos.order(created_at: :asc)
    else
      # 全フォルダのTodoを取得
      todos = current_api_v1_user.todos.order(created_at: :asc)
    end
    render json: { status: 200, todos: todos }
  end
  
  def create
    if @folder
      # フォルダに属するTodoを作成
      todo = @folder.todos.new(todo_params.merge(user_id: current_api_v1_user.id))
    else
      # フォルダに属さないTodoを作成
      todo = current_api_v1_user.todos.new(todo_params)
    end

    if todo.save
      render json: { status: 200, todo: todo }
    else
      render json: { status: 500, message: "Todoの作成に失敗しました", errors: todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    todo = current_api_v1_user.todos.find(params[:id])

    if todo.destroy
      render json: { status: 200, todo: todo }
    else
      render json: { status: 500, message: "Todoの削除に失敗しました" }
    end
  end
  
  def update
    todo = current_api_v1_user.todos.find(params[:id])

    if todo.update(todo_params)
      render json: { status: 200, todo: todo }
    else
      render json: { status: 500, message: "Todoの更新に失敗しました", errors: todo.errors.full_messages }
    end
  end

  def show
    todo = current_api_v1_user.todos.find(params[:id])
    render json: { status: 200, todo: todo }
  rescue ActiveRecord::RecordNotFound
    render json: { status: 404, message: "Todoが見つかりません" }
  end

  def important
    todos = current_api_v1_user.todos.where(is_important: true)
    render json: { status: 200, todos: todos }
  end

  def today
    todos = current_api_v1_user.todos.where(due_date: Date.today)
    render json: { status: 200, todos: todos }
  end

  def completed
    todos = current_api_v1_user.todos.where(completed: true)
    render json: { status: 200, todos: todos }
  end

  private

  def set_folder
    # フォルダIDがリクエストに含まれている場合にフォルダを取得
    @folder = current_api_v1_user.folders.find_by(id: params[:folder_id])
  end

  def todo_params
    # フォルダ関連のパラメータも許可
    params.require(:todo).permit(:title, :completed, :due_date, :is_important, :folder_id)
  end
end

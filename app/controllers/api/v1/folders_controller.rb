module Api
  module V1
    class FoldersController < ApplicationController
      before_action :authenticate_user! # ユーザー認証を実行
      before_action :set_folder, only: [:show, :update, :destroy]

      def index
        @folders = current_user.folders
        render json: @folders
      end

      def show
        @folder = current_user.folders.find(params[:id])
        render json: {
            folder: @folder,
            todos: @folder.todos
        }
      end

      def create
        @folder = current_user.folders.build(folder_params)
        if @folder.save
          render json: @folder, status: :created
        else
          render json: @folder.errors, status: :unprocessable_entity
        end
      end

      def update
        if @folder.update(folder_params)
          render json: @folder
        else
          render json: @folder.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @folder.destroy
        head :no_content
      end

      private

      def set_folder
        @folder = current_user.folders.find(params[:id])
      end

      def folder_params
        params.require(:folder).permit(:name)
      end
    end
  end
end

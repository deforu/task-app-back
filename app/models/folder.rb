class Folder < ApplicationRecord
  belongs_to :user
  has_many :todos, dependent: :destroy # todosテーブルとの関連付け
end
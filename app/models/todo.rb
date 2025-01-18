class Todo < ApplicationRecord
  belongs_to :user
  belongs_to :folder, optional: true # フォルダに属さないタスクを許容する場合はoptional: trueを指定

  validates :title, presence: true, length: { maximum: 140 }
  validates :completed, inclusion: { in: [true, false] }
  validates :due_date, presence: true
  validates :is_important, inclusion: { in: [true, false] }

  scope :today, -> { where(due_date: Date.today) }
  scope :important, -> { where(is_important: true) }
  scope :completed, -> { where(completed: true) }
end
class Todo < ApplicationRecord
  validates :title, presence: true, length: { maximum: 140 }
  validates :completed, inclusion: { in: [true, false] }
  validates :due_date, presence: true
  validates :is_important, inclusion: { in: [true, false] }

  scope :today, -> { where(due_date: Date.today) }
  scope :important, -> { where(is_important: true) }
  scope :completed, -> { where(completed: true) }
end
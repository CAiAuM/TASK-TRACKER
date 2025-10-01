class Task < ApplicationRecord
  has_many :task_sessions, dependent: :destroy

  enum status: {
    pending: 0,
    in_progress: 1,
    completed: 2
  }

  validates :title, presence: true
end

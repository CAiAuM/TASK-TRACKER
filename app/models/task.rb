class Task < ApplicationRecord
  belongs_to :user
  has_many :task_sessions, dependent: :destroy

  validates :title, presence: true

  enum status: {
    pending: 0,
    in_progress: 1,
    completed: 2
  }

end

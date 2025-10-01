class TaskSession < ApplicationRecord
  belongs_to :task

  validates :duration, presence: true, numericality: { greater_than: 0 }
  before_validation :calculate_duration, if: -> { start_time.present? && end_time.present? && duration.blank? }

  private

  def calculate_duration
    self.duration = (end_time - start_time).to_i
  end
end

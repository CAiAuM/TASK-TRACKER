class CreateTaskSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :task_sessions do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :duration
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end

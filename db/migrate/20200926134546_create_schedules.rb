class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :body
      t.string :description
      t.date :start
      t.date :deadline
      t.boolean :done, default: false, null: false
      t.boolean :deadlined, default: false, null: false
      t.datetime :date
      t.integer :date_year
      t.integer :date_month
      t.integer :date_day
      t.boolean :commit, default: true, null: false
      t.string :color
      
      # t.references  :card, null: false, foreign_key: true
      # t.references  :user, null: false, foreign_key: true

      t.date :done_at

      t.timestamps
    end
  end
end

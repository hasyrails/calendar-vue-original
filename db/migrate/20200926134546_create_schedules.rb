class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :body
      t.string :description
      t.datetime :start
      t.integer :start_year
      t.integer :start_month
      t.integer :start_date
      t.datetime :end
      t.integer :end_year
      t.integer :end_month
      t.integer :end_date
      t.string :color
      t.boolean :commit, default: true, null: true

      t.references  :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end

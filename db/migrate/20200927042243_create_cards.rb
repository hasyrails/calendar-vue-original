class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string  :body
      t.text  :description
      t.integer  :scheduled
      t.date :start
      t.date :end
      t.integer  :status
      t.integer  :color
      t.boolean :schedulized, default: false, null: false
      t.references  :list, null: false, foreign_key: true
      t.timestamps
    end
  end
end

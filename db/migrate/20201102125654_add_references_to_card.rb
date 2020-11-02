class AddReferencesToCard < ActiveRecord::Migration[5.2]
  def change
    add_reference :cards, :user, foreign_key: true
    add_reference :cards, :schedule, foreign_key: true
  end
end

class Card < ApplicationRecord
  belongs_to :list, optional: true
  has_many :schedule, dependent: :destroy

  enum status: { todo: 0, doing: 1, done: 2 }
  enum scheduled: { non_scheduled: 0, scheduled: 1 }
end

class Schedule < ApplicationRecord
  belongs_to :card
  belongs_to :user, dependent: :destroy

  # enum color: { FFD5EC: 0, CBFFD3: 1, CCFFFF: 2 }
end

class Schedule < ApplicationRecord
  belongs_to :card, optional: true
  belongs_to :user, dependent: :destroy, optional: true

  # enum color: { FFD5EC: 0, CBFFD3: 1, CCFFFF: 2 }
end

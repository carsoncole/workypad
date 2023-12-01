class Feedback < ApplicationRecord
  belongs_to :user

  enum status: { submitted: 1, considering: 2, implemented: 3, considered: 4}
end

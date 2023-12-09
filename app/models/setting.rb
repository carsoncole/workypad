class Setting < ApplicationRecord
  belongs_to :user, dependent: :destroy
end

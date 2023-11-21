class Job < ApplicationRecord
  enum status: { research: 0, applied: 1, interview: 2, test: 3, offer: 4, archived: 5 }

  belongs_to :user
  has_many :notes, dependent: :destroy

  validates :entity, :title, :status, presence: true
end

class Reminder < ApplicationRecord
  belongs_to :job

  enum :way, [ "follow up message", "follow up call" ], default: "follow up call"

  scope :due, -> { where("remind_at < ?", Time.now) }
  scope :not_due, -> { where("remind_at > ?", Time.now) }

  DAYS_TO_REMIND = [1,7,14]

  attr_accessor :days_to_remind

  before_create :set_reminder!

  validates :job_id, uniqueness: true

  def days_to_remind
    @days_to_remind || 7
  end

  private

  def set_reminder!
    self.remind_at = (Time.now + self.days_to_remind.to_i.days).beginning_of_day
  end
end


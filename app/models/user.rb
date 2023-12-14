#TODO remove forgot password
#TODO flash notice of sign up problems
class User < ApplicationRecord
  include Clearance::User

  has_one :setting
  has_many :jobs, dependent: :destroy
  has_many :notes, through: :jobs
  has_many :feedbacks, dependent: :destroy

  after_create :create_setting!


  # badge award if applied > 2 times today
  def application_badge?
    notes.applied.where("notes.created_at > ?", Date.today.beginning_of_day).count > 2
  end

  # badge award if applied > 2 times today
  def fire_badge?
    notes.applied.where("notes.created_at > ?", Date.today.beginning_of_day).count > 4
  end

  private

  def create_setting!
    create_setting
  end
end

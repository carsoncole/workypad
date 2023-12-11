#TODO remove forgot password
#TODO flash notice of sign up problems
class User < ApplicationRecord
  include Clearance::User

  has_one :setting
  has_many :jobs, dependent: :destroy
  has_many :notes, through: :jobs
  has_many :feedbacks, dependent: :destroy

  after_create :create_setting!

  def create_setting!
    create_setting
  end
end

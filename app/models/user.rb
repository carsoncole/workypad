#TODO remove forgot password
class User < ApplicationRecord
  include Clearance::User

  has_many :jobs, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
end

class User < ApplicationRecord
  include Clearance::User

  has_many :jobs, dependent: :destroy
end

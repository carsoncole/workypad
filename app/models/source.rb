class Source < ApplicationRecord
  SOURCES = ["Indeed", "Other", "Ziprecruitor", "LinkedIn", "Dice", "Google", "Bing", "Referral", "Jobot", "Simply Hired", "Company site"]
  belongs_to :user, optional: true
end

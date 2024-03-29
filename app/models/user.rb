class User < ApplicationRecord
  include Clearance::User

  has_one :setting
  has_many :jobs, dependent: :destroy
  has_many :notes, through: :jobs
  has_many :feedbacks, dependent: :destroy
  has_many :sources, dependent: :destroy

  after_create :create_setting!
  after_create :create_initial_sources!


  # badge award if applied > 2 times today
  def application_badge?
    notes.applied.where("notes.created_at > ?", Time.zone.now.to_date.beginning_of_day).count > 2
  end

  # badge award if applied > 2 times today
  def fire_badge?
    notes.applied.where("notes.created_at > ?", Time.zone.now.beginning_of_day).count > 4
  end

  private

  def create_setting!
    create_setting
  end

  def create_initial_sources!
    Source::SOURCES.each do |source_name|
      self.sources.create(name: source_name)
    end
  end
end

#TODO change integer ID to UUID
class Job < ApplicationRecord
  include RankedModel
  ranks :order,
    with_same: :user_id

  attr_accessor :position

  enum status: { research: 0, applied: 1, interview: 2, test: 3, offer: 4, archived: 5 }
  enum mode: { office: 1, hybrid: 2, remote: 3, other: 9 }
  enum arrangement: { not_set: 1, permanent: 2, contract: 3, contract_to_hire: 4, freelance: 5, internship: 6}

  belongs_to :user
  belongs_to :source, optional: true
  has_many :notes, dependent: :destroy

  validates :entity, :title, :status, presence: true

  # before_create :add_initial_order!
  before_save :update_status_updated_at!, if: ->(obj){ !obj.persisted? || obj.will_save_change_to_status? }
  before_save :update_applied_at!, if: ->(obj){ obj.status_changed?(to: 'applied') }
  before_save :update_archived_at!, if: ->(obj){ obj.status_changed?(to: 'archived') }

  def add_initial_order!
    self.order = (self.user.jobs.order(:order)&.last&.order || 0) + 1
  end

  def reorder_up!
    self.update order_position: :up
    self
  end

  def reorder_down!
    self.update order_position: :down
    self
  end

  private

  def update_status_updated_at!
    self.status_updated_at = Time.now
  end

  def update_applied_at!
    self.applied_at = Date.today
  end

  def update_archived_at!
    self.archived_at = Date.today
  end
end


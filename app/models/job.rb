class Job < ApplicationRecord
  include RankedModel
  ranks :order,
    with_same: :user_id

  has_rich_text :listing

  attr_accessor :position, :updated_by_note

  enum status: { research: 0, applied: 1, interviewed: 2, tested: 3, offered: 4, archived: 5, accepted: 6 }
  enum mode: { office: 1, hybrid: 2, remote: 3, other: 9 }
  enum arrangement: { not_set: 1, full_time: 2, contract: 3, contract_to_hire: 4, freelance: 5, internship: 6}

  belongs_to :user
  belongs_to :source, optional: true
  has_many :notes, dependent: :destroy
  has_many :reminders, dependent: :destroy

  # validates :entity, presence: true, unless: -> (obj){ obj.agency.present? }
  # validates :agency, presence: true, unless: -> (obj){ obj.entity.present? }
  validate :entity_or_agency
  validates :title, :status, presence: true

  before_save :update_status_updated_at!, if: ->(obj){ !obj.persisted? || obj.will_save_change_to_status? }
  after_create :create_initial_note!

  after_save :create_archived_note!, if: -> (obj){obj.status_previously_changed?(to: 'archived')}

  def reorder_up!
    self.update order_position: :up
    self
  end

  def reorder_down!
    self.update order_position: :down
    self
  end

  def days_since_last_note?
    if notes.any?
      exact_days_since_last_note?.floor
    else
      nil
    end
  end

  def exact_days_since_last_note?
    if notes.any?
      (Time.now - notes.order(:created_at).last.created_at).to_f/1.day
    else
      nil
    end
  end

  def card_color?
    if days_since_last_note?.nil?
      'border-gray-300'
    elsif days_since_last_note? < 2
      'border-red-400'
    elsif days_since_last_note? < 5
      'border-red-300'
    elsif days_since_last_note? < 9
      'border-gray-300'
    elsif days_since_last_note? < 15
      'border-blue-300'
    elsif days_since_last_note? < 20
      'border-blue-500'
    else
      'border-blue-700'
    end
  end

  def card_status_color?
    if days_since_last_note?.nil?
      'bg-gray-300'
    elsif days_since_last_note? < 2
      'bg-red-400'
    elsif days_since_last_note? < 5
      'bg-red-300'
    elsif days_since_last_note? < 9
      'bg-gray-300'
    elsif days_since_last_note? < 15
      'bg-blue-300'
    elsif days_since_last_note? < 20
      'bg-blue-500'
    else
      'bg-blue-700'
    end
  end

  def self.search(user, query)
    user.jobs.where("entity ILIKE ? OR agency ILIKE ? OR title ILIKE ? OR primary_contact_name ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%").order(:order)
  end

  private

  def update_status_updated_at!
    self.status_updated_at = Time.now
  end

  def entity_or_agency
    if [entity, agency].compact.delete_if(&:empty?).count == 0
      errors.add(:base, "Specify at least one entity or agency")
    end
  end

  def create_initial_note!
    self.notes.create(category: 'created', content: "Created")
  end

  def create_archived_note!
    self.notes.archived.create(content: "Archived") unless self.updated_by_note
  end
end


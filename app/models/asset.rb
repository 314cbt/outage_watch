class Asset < ApplicationRecord
  has_many :incidents, dependent: :nullify
  has_many :work_orders, dependent: :nullify

  enum :status, { active: "active", down: "down", maintenance: "maintenance" }, prefix: true

  CATEGORIES = %w[substation feeder transformer breaker recloser pole meter].freeze
  validates :category, inclusion: { in: CATEGORIES }, allow_nil: true

  validates :name, presence: true
end

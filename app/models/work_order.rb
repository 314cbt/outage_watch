class WorkOrder < ApplicationRecord
  belongs_to :asset

  enum :status,   { open: "open", in_progress: "in_progress", done: "done", canceled: "canceled" }, prefix: :status
  enum :priority, { low: "low", normal: "normal", high: "high", urgent: "urgent" },               prefix: :priority

  validates :asset, presence: true
  validates :title, presence: true, length: { maximum: 120 }
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :priority, presence: true, inclusion: { in: priorities.keys }
  validates :description, length: { maximum: 5000 }, allow_blank: true
end

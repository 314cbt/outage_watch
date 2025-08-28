class Incident < ApplicationRecord
  belongs_to :asset
  has_many :incident_events, dependent: :destroy

  enum :status,   { open: "open", monitoring: "monitoring", resolved: "resolved" }, prefix: true
  enum :severity, { minor: "minor", moderate: "moderate", major: "major", critical: "critical" }, prefix: true

  scope :with_status,   ->(val) { where(status: val) if val.present? }
  scope :with_severity, ->(val) { where(severity: val) if val.present? }
  scope :started_from,  ->(ts)  { where(Incident.arel_table[:started_at].gteq(ts)) if ts.present? }
  scope :started_to,    ->(ts)  { where(Incident.arel_table[:started_at].lteq(ts)) if ts.present? }
  scope :search,        ->(q)   {
    if q.present?
      where("cause ILIKE :q OR notes ILIKE :q", q: "%#{sanitize_sql_like(q)}%")
    end
  }

  validates :status, presence: true
  validates :severity, presence: true
end

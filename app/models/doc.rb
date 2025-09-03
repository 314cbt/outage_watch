class Doc < ApplicationRecord
  has_one_attached :file
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9\-]+\z/ }
  validates :title, presence: true
end

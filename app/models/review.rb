class Review < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :post, optional: true

  validates :title, presence: true

  validates :content, presence: true

  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5
  }, presence: true
end

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  has_many :notifications, dependent: :destroy
end

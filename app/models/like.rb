class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user, foreign_key: :user_id
  validates_uniqueness_of :post_id, scope: :user_id #一意性。ユーザーは1投稿あたり1いいねしかできない。
end

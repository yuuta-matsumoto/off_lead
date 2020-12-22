class Post < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :reviews
  mount_uploader :img, ImgUploader
  has_many :likes, dependent: :destroy
  has_many :liked_uses, through: :likes, source: :user #post.liked_usersでpostのいいね一覧を取り出せる。
  has_many :notifications, dependent: :destroy
end

class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :price, presence: true


  belongs_to :user
  has_many :reviews, dependent: :destroy
  mount_uploader :img, ImgUploader
  has_many :likes, dependent: :destroy
  has_many :liked_uses, through: :likes, source: :user #post.liked_usersでpostのいいね一覧を取り出せる。
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable
  #ユーザーの画像をアップロードする
  mount_uploader :img, ImgUploader

  has_many :posts,    dependent: :destroy
  has_many :reviews
  has_many :messages, dependent: :destroy
  has_many :entries,  dependent: :destroy
  has_many :likes,    dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post #user.liked_postsでuserのいいねした投稿を一気に取り出せる。
end

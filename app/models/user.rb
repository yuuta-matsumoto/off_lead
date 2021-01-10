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
  
  has_many :reviews, dependent: :destroy

  #フォロー機能のアソシエーション
  has_many :following, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  has_many :following_user, through: :following, source: :follower
  has_many :follower_user, through: :follower, source: :following
  
  #フォロー機能のメソッド
  def follow(user_id)
    following.create(follower_id: user_id)
  end

  def unfollow(user_id)
    following.find_by(follower_id: user_id).destroy
  end

  def following?(user_id)
    following_user.include?(user_id)
  end

  #いいね機能のメソッド
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
end

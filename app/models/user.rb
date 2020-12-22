class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable
  #ユーザーの画像をアップロードする
  mount_uploader :img, ImgUploader
  # リレーションシップ
  has_many :posts,    dependent: :destroy
  has_many :reviews
  has_many :messages, dependent: :destroy
  has_many :entries,  dependent: :destroy
  has_many :likes,    dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post #user.liked_postsでuserのいいねした投稿を一気に取り出せる。
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy #自分からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy #相手からの通知

  #バリデーション
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
end

class Post < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :reviews
  mount_uploader :img, ImgUploader
  has_many :likes, dependent: :destroy
  has_many :liked_uses, through: :likes, source: :user #post.liked_usersでpostのいいね一覧を取り出せる。

  def self.search(search)
    if search
      Post.where(['content LIKE ?', "%#{search}%"])
    else
      Post.all
    end
  end
end

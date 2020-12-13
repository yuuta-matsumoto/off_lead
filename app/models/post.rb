class Post < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :reviews
  mount_uploader :img, ImgUploader
end

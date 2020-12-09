class Post < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates :title, presence: {message: "タイトルを入力してください"}
end

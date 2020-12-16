class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable
  
  has_many :posts, dependent: :destroy
  has_many :reviews
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
end

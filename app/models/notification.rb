class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) } #デフォルトの並び順を降順にする
  belongs_to :post, optional: true #nilを許可
  belongs_to :message, optional: true #nilを許可
  belongs_to :rebiew, optional: true #nilを許可

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end

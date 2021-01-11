class ChangeReviewColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :reviewer_name, :string
    add_column :reviews, :reviewer_img,  :string
  end
end

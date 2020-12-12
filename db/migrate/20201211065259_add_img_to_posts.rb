class AddImgToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :img, :string
  end
end

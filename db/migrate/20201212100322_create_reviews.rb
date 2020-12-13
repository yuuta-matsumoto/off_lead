class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.text :title
      t.text :content

      t.timestamps
    end
  end
end

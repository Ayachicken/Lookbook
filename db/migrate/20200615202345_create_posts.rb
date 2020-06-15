class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :post_title, null: false
      t.text :posted_text, null: false

      t.timestamps
    end
  end
end

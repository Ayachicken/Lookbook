class CreateInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiries do |t|
      t.string :name, null: false
      t.text :message, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end

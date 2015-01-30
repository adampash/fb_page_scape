class Schema < ActiveRecord::Migration
  def change
    create_table :posts, force: true do |t|
      t.string :title
      t.string :fb_id
      t.string :from_id
      t.string :from_name
      t.string :to_name
      t.string :to_id
      t.text :message
      t.text :post_type
      t.text :picture
      t.text :link
      t.text :name
      t.text :caption
      t.text :description
      t.text :url
      t.datetime :created_time
      t.datetime :updated_time
    end
  end
end

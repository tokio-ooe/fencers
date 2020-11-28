class CreateRecruits < ActiveRecord::Migration[5.2]
  def change
    create_table :recruits do |t|
      t.string :title
      t.text :body
      t.text :position
      t.string :reward
      t.integer :user_id
      t.timestamps
    end
  end
end

class CreateRecruits < ActiveRecord::Migration[5.2]
  def change
    create_table :recruits do |t|
      t.string :title
      t.text :body
      t.text :position
      t.string :reward
      t.integer :user_id
      t.date :date
      t.text "setlist"
      t.timestamps
    end
  end
end

class CreateRecruitComments < ActiveRecord::Migration[5.2]
  def change
    create_table :recruit_comments do |t|

      t.timestamps
    end
  end
end

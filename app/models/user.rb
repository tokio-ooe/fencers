class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recruits
	has_many :favorites, dependent: :destroy
	has_many :recruit_comments, dependent: :destroy
	has_many :active_notifications, foreign_key:"visitor_id", class_name: "Notification", dependent: :destroy
  has_many :passive_notifications, foreign_key:"visited_id", class_name: "Notification", dependent: :destroy
	attachment :profile_image, destroy: false

	enum capacity_status: {"A級":0, "B級":1, "C級":3, "P級":4, "E級":5, "国際審判員":6, "無し":7}

end

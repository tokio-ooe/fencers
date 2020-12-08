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
	
  
   # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  validates :name, length: {maximum: 20, minimum: 2}

  def follow(user_id)
    relationships.create!(followed_id:user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id:user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
  
  # def relationshiped_by?(user)
  #   relationships.where(user_id: user.id).exists?
  # end

end

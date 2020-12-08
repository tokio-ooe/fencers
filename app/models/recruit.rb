class Recruit < ApplicationRecord

  belongs_to :user
	 has_many :favorites, dependent: :destroy
	 has_many :recruit_comments, dependent: :destroy
	 has_many :notifications, dependent: :destroy
  validates :date, presence:true
  validates :title, presence:true
  validates :body, presence:true
  validates :reward, presence:true
  validates :position, presence:true

  def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def create_notification_favorite!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and recruit_id = ? and action = ? ",current_user.id, user_id, id, 'favorite'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        recruit_id: id,
        visited_id: user_id,
        action: 'favorite'
      )

      if notification.visitor_id == notification.visited_id
         notification.checked = true
      end
      notification.save if notification.valid?
    end

    def create_notification_recruit_comment!(current_user, recruit_comment_id)
    #同じ投稿にコメントしているユーザーに通知を送る。（current_userと投稿ユーザーのぞく）
    temp_ids = RecruitComment.where(recruit_id: id).where.not("user_id=? or user_id=?", current_user.id,user_id).select(:user_id).distinct
    #取得したユーザー達へ通知を作成。（user_idのみ繰り返し取得）
    temp_ids.each do |temp_id|
      save_notification_recruit_comment!(current_user, recruit_comment_id, temp_id['user_id'])
    end
    #投稿者へ通知を作成
    save_notification_recruit_comment!(current_user, recruit_comment_id, user_id)
    end

    def save_notification_recruit_comment!(current_user, recruit_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      recruit_id: id,
      recruit_comment_id: recruit_comment_id,
      visited_id: visited_id,
      action: 'recruit_comment')
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
    end
  end
  

end

module NotificationsHelper
  def notification_form(notification)
    #通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    #コメントの内容を通知に表示する
    @recruit_comment = nil
    @visitor_comment = notification.recruit_comment_id
    # notification.actionがfollowかlikeかcommentかで処理を変える
    case notification.action
    when 'follow'
      #aタグで通知を作成したユーザーshowのリンクを作成
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'があなたをフォローしました'
    when 'favorite'
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: recruit_path(notification.recruit_id)) + 'にいいねしました'
    when 'recruit_comment' then
      #コメントの内容と投稿のタイトルを取得
      @recruit_comment = RecruitComment.find_by(id: @visitor_comment)
      @recruit_comment_commrnt =@recruit_comment.comment
      @recruit_title =@recruit_comment.recruit.title
      tag.a(@visitor.name, href: user_path(@visitor)) + 'が' + tag.a("#{@recruit_title}", href: recruit_path(notification.recruit_id)) + 'にコメントしました'
    end
  end
  
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end

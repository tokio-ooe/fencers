class NotificationsController < ApplicationController
    
    def index
        @notifications2 = Notification.where(visited_id: current_user.id).order('created_at')
        #通知画面を開くとcheckedをtrueにして通知確認済にする
        @notifications2.where(checked: false).each do |notification|
          notification.update_attributes(checked: true)
        end
    end

    def destroy
        @notifications =current_user.passive_notifications.destroy_all
        redirect_to notifications_path
    end
end

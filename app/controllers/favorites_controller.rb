class FavoritesController < ApplicationController
   before_action :authenticate_user!

  def create
    @recruit = Recruit.find(params[:recruit_id])
    favorite = @recruit.favorites.new(user_id: current_user.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    @recruit = Recruit.find(params[:recruit_id])
    favorite = @recruit.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    redirect_to request.referer
  end
end

class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @recruits = @user.recruits.page(params[:page]).per(10).reverse_order
  end

  def index
    @users = User.all
    @recruit = Recruit.new
  end

  def edit
  end
  
  def favorites
    @user = User.find(params[:user_id])
    # userがいいねしている記事を呼び出す
    @recruits = Recruit.joins(:favorites).where(favorites: {user_id: @user.id})
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :belong, :capacity_status)
  end
  
  def follow
    @user = User.find(params[:id])
  end
  def follower
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end



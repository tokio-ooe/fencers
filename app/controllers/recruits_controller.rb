class RecruitsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @recruit = Recruit.find(params[:id])
    @recruit_comment = RecruitComment.new
  end

  def index
    @recruits = Recruit.all
    @recruit = Recruit.new
  end

  def create
    @recruit = Recruit.new(recruit_params)
    @recruit.user_id = current_user.id
    if @recruit.save
      redirect_to recruit_path(@recruit), notice: "You have created recruit successfully."
    else
      @recruits = Recruit.all
      render 'index'
    end
  end

  def edit
    @recruit = Recruit.find(params[:id])
    if @recruit.user_id != current_user.id
      redirect_to recruits_path
    end
  end

  def update
    @recruit = Recruit.find(params[:id])
    if @recruit.update(recruit_params)
      flash[:notice] = "You have updated recruit successfully."
      redirect_to recruit_path(@recruit.id)
    else
      render '/recruits/edit'
    end
  end

  def destroy
    @recruit = Recruit.find(params[:id])
    @recruit.destroy
    redirect_to recruits_path
  end

  private

  def recruit_params
    params.require(:recruit).permit(:title, :body, :position, :reward,)
  end

  def ensure_correct_user
    @recruit = Recruit.find(params[:id])
    unless @recruit.user == current_user
      redirect_to recruits_path
    end
  end

end



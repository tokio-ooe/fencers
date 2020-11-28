class RecruitCommentsController < ApplicationController
  before_action :authenticate_user!

	def create
		@recruit = Recruit.find(params[:recruit_id])
		@recruit_comment = RecruitComment.new(recruit_comment_params)
		@recruit_comment.recruit_id = @recruit.id
		@recruit_comment.user_id = current_user.id
		if @recruit_comment.save
  		redirect_to request.referer
  		# render 'recruit/index'
		else
		  render 'recruits/show'
		end
	end

	def destroy
		@recruit = Recruit.find(params[:recruit_id])
  	recruit_comment = @recruit.recruit_comments.find(params[:id])
		recruit_comment.destroy
		redirect_to request.referer
  # 	render 'recruit/index'
	end

	private
	def recruit_comment_params
		params.require(:recruit_comment).permit(:comment)
	end
end

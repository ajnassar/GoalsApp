class CheersController < ApplicationController
  def create
    @cheer = Cheer.new
    @cheer.user = current_user
    @goal = Goal.find(params[:goal_id])
    @cheer.goal_id = params[:goal_id]
    @cheer.save
    redirect_to user_goal_url(@goal.user_id, params[:goal_id])
  end

  def destroy
    @cheer = Cheer.find(params[:id])
    @goal = @cheer.goal
    @user = @goal.user
    redirect_to user_goal_url(@user, @goal)
  end
end

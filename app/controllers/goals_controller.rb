class GoalsController < ApplicationController
  def new
    render :new
  end

  def create
    @goal = Goal.new(params[:goal])
    @goal.user = current_user
    @goal.is_private ||= false

    if @goal.save
      redirect_to user_goal_url(@goal.user_id, @goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def destroy
  end

  def index
    @users = User.all
    @goals = current_user.visible_goals
  end

  def show
    @goal = Goal.find(params[:id])
    @user = @goal.user

    if @goal.is_private && @user != current_user
      redirect_to goals_url
    else
      render :show
    end
  end
end

class StatusesController < ApplicationController
  def create
    @user = current_user
    @status = Status.new(find_params)
    @status.user = @user
    if @status.save
      redirect_to feed_path(@user, anchor: "status-#{@status.id}")
    else
      render '/feed'
    end
    # @statuses = Status.find_by(user_id == current_user)
  end

  private

  def find_params
    params.require(:status).permit(:content)
  end
end

class ClubRequestsController < ApplicationController
  before_action :user_signed_in

  def new
    @club_request = ClubRequest.new
  end

  def create
    request = ClubRequest.new request_params
    @user = admin
    if request.save
      ApplicationMailer.sent_request_club.deliver
      # message_to_room @user.chatwork, "#{Settings.club_request_admin}"
      flash[:success] = t("success_create")
    else
      flash_error request
    end
    redirect_to root_path
  end

  private
  def request_params
    params.require(:club_request).permit(:name,
      :description, :action).merge! user_id: current_user.id,
      organization_id: current_user.organization_id
  end
end

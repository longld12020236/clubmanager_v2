class EventRequestsController < ApplicationController
  before_action :load_club, only: :create

  def new
    @clubs = current_user.clubs
    @event_request = EventRequest.new
  end

  def create
    @request = EventRequest.new request_params
    @manager = UserClub.manager_club.find_by(club_id: @request.club_id)
    @user = User.find_by id: @manager.user_id
    if @request.save
      ApplicationMailer.sent_request_event(@user).deliver
      # message_to_room @user.chatwork, "#{Settings.event_request_admin}"
      # flash[:success] = t("success_create")
    else
      flash_error request
    end
    redirect_to club_member_url(@club)
  end

  private
  def request_params
    params.require(:event_request).permit(:name, :description, :expense,
      :date_start, :duration, :location, :club_id, :image).merge! user_id: current_user.id
  end

  def create_event
    @event = Event.new event_params
    unless @event.save
      flash_error @event
    end
  end

  def load_club
    @club = Club.find_by id: params[:event_request][:club_id]
    unless @club
      flash[:danger] = t("not_found")
      redirect_to root_path
    end
  end

end

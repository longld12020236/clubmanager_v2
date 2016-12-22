class EventRequestsController < ApplicationController

  def new
    @clubs = current_user.clubs
    @event_request = EventRequest.new
  end

  def create
    request = EventRequest.new request_params
    if request.save
      ApplicationMailer.sent_request_club.deliver
      flash[:success] = t("success_create")
    else
      flash_error request
    end
    redirect_to root_path
  end

  private
  def request_params
    params.require(:event_request).permit(:name, :description, :expense,
      :date_start, :duration, :location, :club_id).merge! user_id: current_user.id
  end

  def create_event
    @event = Event.new event_params
    unless @event.save
      flash_error @event
    end
  end

end

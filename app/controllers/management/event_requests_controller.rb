class Management::EventRequestsController < ApplicationController
  before_action :user_signed_in
  before_action :load_event_request, except: :index
  before_action :manager_verify, only: [:edit, :update]
  before_action :load_unapprove

  def index
    @event_requests = EventRequest.unapprove
  end

  def edit
    @event_request = EventRequest.find_by id: params[:id]
  end

  def update
    @club = Club.find_by id: @event_request.club_id
    @users = @club.users
    @event_request.approve = true
    @user = User.find_by id: @event_request.user_id
    if @event_request.update_attributes approve: true
      create_event(@event_request.club_id,
        @event_request.name, @event_request.description, @event_request.expense,
        @event_request.date_start, @event_request.duration, @event_request.location, @event_request.image)
      if @event.save
        ApplicationMailer.accepted_request_event(@user, @event).deliver
        ApplicationMailer.new_event_create(@users, @event).deliver
        # message_to_room @event.club.chatwork,
        # "#{Settings.view_detail}#{get_path(event_path @event)}"
      end
      flash[:succsess] = t("request_approved")
    else
      flash_error @event_request
    end
    render :index
  end

  def destroy
    if @club_request.destroy
      flash[:success] = t("deleted_successfull")
    else
      flash[:danger] = t("delete_unsuccessfull")
    end
    render :index
  end
  private
  def load_event_request
    @event_request = EventRequest.find_by id: params[:id]
    unless @event_request
      flash[:danger] = "Can not found request"
      redirect_to root_path
    end
  end

  def load_unapprove
    @event_requests = EventRequest.unapprove
    unless @event_requests
      flash_error @event_requests
      redirect_to :back
    end
  end

  def create_event(club_id, name, description, expense, date_start,
    duration, location, image)
    @event = Event.new club_id: club_id, name: name,
      description: description, expense: expense, date_start: date_start,
      duration: duration, location: location, image: image
    @event.save
  end
end

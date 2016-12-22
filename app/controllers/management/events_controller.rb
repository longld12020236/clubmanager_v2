class Management::EventsController < ApplicationController
  before_action :load_event, only: [:edit, :update, :destroy]

  def index
    @event = Event.all
  end

  def new
    @event = Event.new
    @clubs = UserClub.user_club_scope(current_user)
  end

  def create
    event = Event.new event_params
    if event.save
      # message_to_room event.club.chatwork,
      #   "#{Settings.view_detail}#{get_path(event_path event)}"
      flash[:succsess] = t "succsess_create"
    else
      flash_error event
    end
    redirect_to root_url
  end

  def edit
  end

  def update
    if @event.update_attributes event_params
      flash[:succsess] = t "succsess_create"
    else
      flash_error @event
    end
    redirect_to root_url
  end

  def destroy
    unless @event.destroy
      flash_error @event
    end
    redirect_to club_member_url(@event)
  end

  private
  def event_params
    params.require(:event).permit :club_id, :name, :date_start,
      :expense, :duration, :location, :description
  end

  def load_event
    @event = Event.find_by id: params[:id]
    unless @event
      flash_error @event
      redirect_to :back
    end
  end
end

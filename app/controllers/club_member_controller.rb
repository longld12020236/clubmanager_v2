class ClubMemberController < ApplicationController
  include ClubMemberHelper

  before_action :load_club, only: [:show, :update]

  def index
    userclub = UserClub.club_scope current_user
    array_id = attribute_object_array(userclub, "club_id")
    if params[:id] == "joined"
      @clubs = current_user.clubs
    else
      @clubs = Club.not_join array_id
    end
  end

  def show
    @events = @club.events
  end

  def edit
    load_club
  end

  def update
    if @club.update_attributes club_member_params
      flash[:succsess] = t("success_update")
    else
      flash_error @club
    end
    redirect_to :back
  end

  def club_member_params
    params[:name] = params[:club_member][:name]
    params[:image] = params[:club_member][:image]
    params[:description] = params[:club_member][:description]
    params[:notification] = params[:club_member][:notification]
    params.permit :name, :description, :notification, :image
  end

end

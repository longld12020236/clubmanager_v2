class Admin::ClubsController < ApplicationController
  before_action :load_organization, only: [:new, :edit]
  before_action :load_club, only: [:update, :edit, :show]

  include ClubMemberHelper
  def new
    @club = Club.new
  end

  def index
  end

  def create
    @users = User.all
    club = Club.new club_params
    club.is_active = true
    if club.save

      flash[:succsess] = t("success_create")
    else
      flash_error club
    end
    redirect_to root_path
  end

  def edit
  end

  def update
    if @club.update_attributes club_params
      flash[:succsess] = t("success_update")
    else
      flash_error @club
    end
    redirect_to root_path
  end
end

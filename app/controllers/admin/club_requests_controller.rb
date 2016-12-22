class Admin::ClubRequestsController < ApplicationController
  before_action :user_signed_in
  before_action :load_club_request, except: :index
  before_action :admin_verify, only: [:edit, :update]
  before_action :load_unapprove

  def index
  end

  def edit
    @club_request = ClubRequest.find_by id: params[:id]
  end

  def update
    @users = User.all
    @club_request.approve = true
    @user = User.find_by id: @club_request.user_id
    if @club_request.update_attributes approve: true
      create_club @club_request.organization_id, @club_request.name, @club_request.description
      if @club.save
        create_manager @user.id, @club.id
        ApplicationMailer.accepted_request_club(@user, @club).deliver
        ApplicationMailer.new_club_open(@users, @club).deliver
      end
      flash[:succsess] = t("request_approved")
    else
      flash_error @club_request
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
  def load_unapprove
    @club_requests = ClubRequest.unapprove
    unless @club_requests
      flash_error @club_requests
      redirect_to :back
    end
  end

  def load_club_request
    @club_request = ClubRequest.find_by id: params[:id]
    unless @club_request
      flash[:danger] = "Can not found request"
      redirect_to root_path
    end
  end

  def create_club organization_id, name, description
    @club = Club.new organization_id: organization_id, name: name,
      description: description
    @club.save
  end

  def create_manager user_id, club_id
    @user_club = UserClub.new user_id: user_id, club_id: club_id, is_manager: true
    @user_club.save
  end
end

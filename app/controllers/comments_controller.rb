class CommentsController < ApplicationController
  before_action :load_news, only: [:create, :update]
  before_action :load_comment, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @comment = Comment.new
  end

  def create
    comment = Comment.new comment_params
    @comments = @news.comments
    unless comment.save
      flash_error comment
      redirect_to :back
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @comments = @news.comments
    unless @comment.update_attributes comment_params
      flash_error comment
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @news = @comment.news
    @comments = @news.comments
    unless @comment.destroy
      flash_error comment
    end
    respond_to do |format|
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge! user_id: current_user.id, news_id: params[:comment][:news_id]
  end

  def load_news
    @news = News.find_by id: params[:comment][:news_id]
    unless @news
      flash[:danger] = t("not_found")
    end
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    unless @comment
      flash[:danger] = t("not_found")
    end
  end
end

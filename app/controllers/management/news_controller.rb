class Management::NewsController < ApplicationController
  before_action :load_news, only: [:edit, :destroy, :update]

  def new
    @news = News.new
    @event_id = params[:event_id]
  end

  def create
    @news = News.new news_params
    unless @news.save
      flash_error @news
    end
    redirect_to news_url(@news)
  end

  def edit
  end

  def update
    unless @news.update_attributes news_params
      flash_error @news
    end
    redirect_to news_url(@news)
  end

  def destroy
    unless @news.destroy
      flash_error @news
    end
    redirect_to event_url(@news.event)
  end

  private
  def news_params
    params.require(:news).permit(:event_id, :title,
      :content, :image).merge! user_id: current_user.id, approve: true
  end

  def load_news
    @news = News.find_by id: params[:id]
    unless @news
      flash[:danger] = t("not_found")
    end
  end

end

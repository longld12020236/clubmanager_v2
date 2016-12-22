class NewsController < ApplicationController
  before_action :load_news, only: :show

  def index

  end

  def show
    @comments = @news.comments
  end

  private
  def load_news
    @news = News.find_by id: params[:id]
    unless @news
      flash[:danger] = t("not_found")
    end
  end
end

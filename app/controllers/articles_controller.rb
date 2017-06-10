class ArticlesController < ApplicationController
  include ArticlesHelper
  def index
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    #@comment = @article.comments.new -> this adds an empty comment in the page
    @comment.article_id = @article.id
  end
  def new
    @article = Article.new
  end

  def create
    #This shortform does not work, for security reasons
    #@article = Article.new(params[:article])
    #Initial approach:
    #@article = Article.new(
      #title = params[:article][:title],
      #body = params[:article][:body])
    #revised approach using permited parameters
    @article = Article.new(article_params)
    @article.save
    flash.notice = "Article '#{@article.title}' created"
    redirect_to article_path(@article)
  end
  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    flash.notice = "Article '#{@article.title}' updated"
    redirect_to article_path(@article)
  end
  def edit
    @article = Article.find(params[:id])
  end
  def destroy
    @article = Article.destroy(params[:id])
    flash.notice = "Article '#{@article.title}' deleted"
    redirect_to articles_path
  end
end

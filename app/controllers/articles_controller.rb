class ArticlesController < ApplicationController
	def new
	end

	def create
		render plain: params[:article].inspect
	end

	def show
		@article = Article.find(params[:id])
	end
end


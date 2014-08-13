class ArticlesController < ApplicationController
	
	#http_basic_authenticate_with name: 'dhh', password: 'secret', except: [:index, "show"]

	def new
		@article = Article.new
	end

	def index
		@articles = Article.all
	end

	def create
		@article = Article.new(article_params)
		@article.user = current_user
		authorize! :create, @article

		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def show
		@article = Article.find(params[:id])
	end

	def edit
		@article = Article.find(params[:id])
		authorize! :edit, @article, :message => 'Unable to edit this article.'

	end

	def update
  		@article = Article.find(params[:id])
 		@article.assign_attributes(article_params)
 		authorize! :update, @article, :message => 'Unable to update this article.'
  		if @article.update(article_params)
    		redirect_to @article
  		else
    		render 'edit'
  		end
	end

	def destroy
		@article = Article.find(params[:id])
		authorize! :destroy, @article, :message => 'Unable to destroy this article.'
		@article.destroy
		redirect_to articles_path
	end

	private
		def article_params
			params.require(:article).permit(:title, :text)
		end
	
end


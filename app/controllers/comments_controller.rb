class CommentsController < ApplicationController

	#http_basic_authenticate_with name: 'dhh', password: 'secret', only: :destroy
'''
	def create
		@article = Article.find(params[:article_id])
		@comment.user = current_user
		@comment = @article.comments.create(comment_params)
		authorize! :create, @comment
		redirect_to article_path(@article)
	end
'''
	def create
    	@article = Article.find(params[:article_id])
		@comment = @article.comments.create(comment_params)
    	if @comment.save
      		flash[:notice] = "Successfully created comment."
      		redirect_to article_url(@comment.article_id)
    	else
      		render :action => 'new'
    	end
  	end

  	
	def destroy
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		authorize! :destroy, @comment, :message => 'Unable to destroy this comment.'
		redirect_to @article
	end
	


	
	private
		def comment_params
			params.require(:comment).permit(:commenter, :body)
		end
end

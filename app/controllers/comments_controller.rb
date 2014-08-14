class CommentsController < ApplicationController

	#http_basic_authenticate_with name: 'dhh', password: 'secret', only: :destroy

	def create
    	@article = Article.find(params[:article_id])
		@comment = @article.comments.build(comment_params)
		@comment.user = current_user
    	if @comment.save
      		flash[:notice] = "Successfully created comment."
      		redirect_to article_url(@comment.article_id)
    	else
      		render :action => 'new'
    	end
  	end

  	
	def destroy
		@article = Article.find(params[:article_id])
		@comment = current_user.comments.by_article(params[:article_id]).find(params[:id])
		authorize! :destroy, @comment, :message => 'Unable to destroy this comment.'
		if @comment.destroy
			redirect_to @article
		end
	rescue ActiveRecord::RecordNotFound
		redirect_to @article, :alert => "Unable to destroy this comment."
	end

	
	private
		def comment_params
			params.require(:comment).permit(:commenter, :body)
		end

end



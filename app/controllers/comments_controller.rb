class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy  

  def create
    @entry = Entry.find_by(id: params[:comment][:entry_id])
  	@comment = @entry.comments.build(comment_params)
  	@comment.user = current_user
  	byebug
  	if @comment.save
  		flash[:success] = 'Created comment'
	  	respond_to do |format|
	      format.html { redirect_to :back, notice: "Comment created" }
	      format.js
    	end
    else
    	flash[:danger] = 'Something went wrong!'
    	redirect_to request.referer
    end
	end

	def destroy
		# @micropost = Micropost.find_by(id: params[:comment][:micropost_id])
		# @micropost.comment.find(params[:id]).destroy
		Comment.find(params[:id]).destroy
		# render json: {status: :deleted}
		respond_to do |format|
			format.html {redirect_to(request.referrer || root_url, notice: "Comment deleted") }
			format.js
		end
	end

  private
	    def comment_params
	      params.require(:comment).permit(:content, :entry_id, :user_id)
	    end
	    	
	    def correct_user
	      @comment = current_user.comments.find_by(id: params[:id])
	      redirect_to root_url if @comment.nil?
	    end
end

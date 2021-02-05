class CommentsController < ApplicationController
before_action :authenticate_user!
  def create
    @post = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post=@post    
    @comment.user=current_user
    if @comment.save
        redirect_to post_path(@post), notice: 'comment created!'
    else
        @comments=@post.comments.order(created_at: :desc)
        render '/posts/show'
    end
end

def destroy    
    @comment=Comment.find params[:id]
    if can? :crud, @comment
        @comment.destroy
        edirect_to post_path(@comment.post), notice: 'comment Deleted!'
    else
        redirect_to root_path, alert: 'Not Authorized!'
    end
end


private
def comment_params
    params.require(:comment).permit(:body, :rating)
end

end

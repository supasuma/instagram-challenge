class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Success!"
      redirect_to posts_path
    else
      flash[:error] = @comment.errors.full_messages
      render 'new'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
      flash[:notice] = 'Comment deleted successfully'
    else
      flash[:alert] = 'Not allowed'
    end
    redirect_to '/posts'
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end

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

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end

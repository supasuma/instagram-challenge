class PostsController < ApplicationController

  #before all authenticate user....except index & show
  # before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(permit_post)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "Success!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      @post.update(permit_post)
    else
      flash[:alert] = 'Not allowed'
    end
    redirect_to '/posts'
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      @post.destroy
      flash[:notice] = 'Foto deleted successfully'
    else
      flash[:alert] = 'Not allowed'
    end
    redirect_to '/posts'
  end


  private

    def permit_post
      params.require(:post).permit(:image, :description)
    end
end

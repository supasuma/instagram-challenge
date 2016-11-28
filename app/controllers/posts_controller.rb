class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :owned_post, only: [:edit, :update, :destroy]

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
    @post.update(permit_post)
    flash[:success] = "Post updated!"
    redirect_to posts_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = 'Post deleted!'
    redirect_to posts_path
  end


  private

    def permit_post
      params.require(:post).permit(:image, :description)
    end

    def owned_post
      @post = Post.find(params[:id])
      unless current_user == @post.user
        flash[:alert] = "Sorry, that post doesn't belong to you!"
        redirect_to posts_path
      end
    end

end

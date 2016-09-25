module Api
  class PostsController < ApplicationController

    before_action :authenticate_user

    def index
      render json: Post.all.to_json
    end

    def show
      post = Post.find(params[:id])
      render json: post.to_json
    end

    def create
      post = Post.new(post_params)
      if post.save
        render json: post.to_json
      else
        render json: post.errors.to_json
      end
    end

    def update
      post = Post.find(params[:id])
      if post.update(post_params)
        render json: post.to_json
      else
        render json: post.errors.to_json
      end
    end

    def destroy
      post = Post.find(params[:id])
      post.destroy
    end

    private

    def post_params
      params.require(:post).permit(:title, :body, :username)
    end
  end
end

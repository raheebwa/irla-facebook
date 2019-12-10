# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy like_comment like_post]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order(updated_at: :desc)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like_post
    @post.likes.build(user_id: params[:user_id], post_id: params[:id]).save
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'You liked a post!.' }
      format.js { render inline: 'location.reload();' }
    end
  end

  def like_comment
    @post.likes.build(user_id: params[:user_id], comment_id: params[:comment_id]).save
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'You liked a comment!.' }
      format.js { render inline: 'location.reload();' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params[:post] = params if params[:post].nil?
    params.require(:post).permit(:user_id, :body, :image_path)
  end
end

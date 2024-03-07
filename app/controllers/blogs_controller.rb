# app/controllers/blogs_controller.rb

class BlogsController < ApplicationController

  # GET /blogs or /blogs/page/:page
  def index
    per_page = 10
    sort_order = params[:order] == 'asc' ? 'created_at ASC' : 'created_at DESC'
    @blogs = Blog.all.order(sort_order).page(params[:page]).per(per_page)
    render json: @blogs
  end

  # POST /blogs
  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      render json: @blog, status: :created
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /blogs/:id
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      render json: @blog
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  # DELETE /blogs/:id
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    render json: { notice: 'Blog was successfully removed.' }
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :content)
  end
end
# app/controllers/blogs_controller.rb

class Api::V1::BlogsController < ApplicationController

  # GET /blogs or /blogs/page/:page
  # need sort order GET /blogs?order=asc or GET /blogs?order=desc
  def index
    per_page = 5
    sort_order = params[:order] == 'ascend' ? 'created_at ASC' : 'created_at DESC'
    @blogs = Blog.all.order(sort_order).page(params[:page]).per(per_page)
    render json: { resources: @blogs, pager: {
      page: params[:page] || 1,
      per_page: 5,
      count: Blog.count
    }}
   end

  def show
    blog = Blog.find params[:id]
    render json: { resource: blog }
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
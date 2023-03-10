class Api::V2::BooksController < ApplicationController
  before_action :set_recipe, only: %i[show destroy] 
  def index
    book = Book.all
    render json: book
  end

  def create
    book = Book.create!(book_params)
    if book.save 
      render json: book
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @book
  end

  def destroy
    @book&.destroy
    render json: { message: 'Book is deleted!' }
  end

  def updated
    if @book.update
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def latest
    @post = Post.last
    render json: @post
  end

  private

  def set_recipe
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :author, :price, :category)
  end
end

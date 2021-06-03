class BooksController < ApplicationController
  before_action :correct_post,only: [:edit,:destroy]

  def index
    @books = Book.all
    @book_new = Book.new
    @user = current_user
  end

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    @user = current_user
    if @book_new.save
      flash[:notice] = "Book was successfully created."
      redirect_to @book_new
    else
      @books = Book.all.order(id: :asc)
      flash[:notice] = "error"
      render("books/index")
    end
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to @book
    else
      flash[:notice] = "error"
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to books_path
  end

  def correct_post
      @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end

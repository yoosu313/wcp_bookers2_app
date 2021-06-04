class UsersController < ApplicationController
  before_action :correct_user,only: [:edit]

  def index
    @users = User.all
    @user = current_user
    @book_new = Book.new
  end

  def show
    @user = User.find(params[:id])
    # ここでユーザーのみの投稿を表示させる記述
    @books = @user.books
    @book_new = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Profile data was successfully updated."
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "error"
      render :edit
    end
  end

  def correct_user
        @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end

end

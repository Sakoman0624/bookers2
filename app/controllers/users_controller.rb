class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit]
  # def create
  # @book = Book.new(book_params)
  # @book.user = current_user
  #   if @book.save
  #     flash[:notice] = "You have created book successfully."
  #     redirect_to book_path(@book.id)
  #   else
  #     flash.now[:notice] = ""
  #     @book = Book.all
  #     render :index
  #   end
  # end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end

    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end

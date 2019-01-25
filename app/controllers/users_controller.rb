class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
    @book = Book.new

    @books = current_user.books
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    # current_userとはログインしているユーザーを呼び出せる記述
    @user = current_user
    @book = Book.new

    @users = User.all
  end

  def top
  end

  def about
  end

private
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

end

class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    if @user.save
      flash[:notice] = "Successfully"
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


private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end

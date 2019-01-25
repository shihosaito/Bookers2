class BooksController < ApplicationController

    before_action :authenticate_user!

def index
    @books = Book.all
	@user = current_user
    @book = Book.new
end

def new
	@book = Book.new
end

def create
    @books = Book.all
    @user = current_user
	@book = Book.new(book_params)

	@book.user_id = current_user.id
    if @book.save
    flash[:notice] = "Successfully"
    redirect_to book_path(@book.id)
    # redirect_to "/books/book.id"
    # redirect_to "/books/:id"
    # redirect_to "/books/params[:id]"
    else
    render :index #viewに飛ぶ
    end
end

def edit
    @book = Book.find(params.id)
end

def update
    @user = current_user
    @book = Book.new(book_params)

    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "Successfully"
    else flash[:notice] = "Error"
    end
    redirect_to book_path(book.id)
  end

def show
	@user = current_user
	@book = Book.new

	@books = Book.find(params[:id])
end

def destroy
    book = Book.find(params[:id])
    book = destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
end


private

def book_params
    params.require(:book).permit(:title, :body)
end


end
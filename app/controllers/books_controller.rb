class BooksController < ApplicationController

    before_action :authenticate_user!
    # before_action :current_user_only, only:[:edit]

    def index
        @books = Book.all
    	@user = current_user
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
        else flash[:notice] = "Error"
        render :index #viewに飛ぶ
        end
    end

    def edit
        @book = Book.find(params[:id])
        @user = @book.user
        if @user != current_user
        redirect_to book_path(params[:id])
        end
    end

    def update
        # @user = @books.user
        # @book = Book.new  #要らない

        book = Book.find(params[:id])
        if book.update(book_params)
          flash[:notice] = "Successfully"
        else flash[:notice] = "Error"
        end
        redirect_to book_path(book.id)
    end

    def show
    	@book = Book.new

    	@books = Book.find(params[:id])
        # @user = User.find(@books.user_id)間違い
        @user = @books.user
    end

    def destroy
        book = Book.find(params[:id])
        book.destroy
        flash[:notice] = "Book was successfully destroyed."
        redirect_to books_path
    end


    private

    # def current_user_only
    #  if @user != current_user
    #     redirect_to book_path(params[:id])
    #  end
    # end

    def book_params
        params.require(:book).permit(:title, :body)
    end
end
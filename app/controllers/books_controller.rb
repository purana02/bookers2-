class BooksController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @booknew=Book.new
  end

  def index
    @books=Book.all
    @book=Book.new
    @userinfo=User.find(current_user.id)
  end

  def create
   @userinfo=User.find(current_user.id)
   @books= Book.all
   @book = Book.new(book_params)
   @book.user_id = current_user.id
   if @book.save
      flash[:notice]="You have createded books successfully."
      redirect_to book_path(@book)
   else
      render "/books/index"
   end
  end

  def show
    @booknew=Book.new
    @book=Book.find(params[:id])
    @userinfo=@book.user
  end

  def edit
    @book=Book.find(params[:id])
  end

  def update
    @book= Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice]="You have updated book successfully."
       redirect_to book_path(@book)
    else
       render :edit
    end
  end

  def destroy
    @book= Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end

end

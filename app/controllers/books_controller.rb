class BooksController < ApplicationController
  def index
    @books = Book.all#データ(レコード)を全て取得
    @book = Book.new# 新規投稿
    @user = current_user# 現在ログインしているユーザーの情報を取得できるメソッド
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])#データ(レコード)を1件取得
    @user = @book.user# 本の投稿者が誰なのか
  end

  def edit
    @book = Book.find(params[:id])#データ(レコード)を1件取得
    @user = @book.user# 本の投稿者が誰なのか
    if @user == current_user# 本の投稿者だったら
      render :edit# その本の編集画面へ遷移
    else# でなければ
      redirect_to books_path
    end
  end

  def create
    @book = Book.new(book_params)# 何を新しく保存するのかを指定
    @book.user_id = current_user.id# 誰が投稿したのかを指定　# セーブ直前の行に記述する→保存の前にユーザーIDと関連しているという記述をすることで連動する
    if @book.save# もし保存ができたら
      flash[:notice] = "You have created book successfully."# サクセスメッセージを表示
      redirect_to book_path(@book.id)# 投稿詳細画面へ遷移
    else# でなければ
      @books = Book.all#データ(レコード)を全て取得
      @user = current_user# 現在ログインしているユーザーの情報を取得できるメソッド

      render :index# 投稿一覧画面へ遷移
    end
  end

  def update
    @book = Book.find(params[:id])# どれ（本）をを更新するのかを指定
    if @book.update(book_params)# もし更新ができたら
      flash[:notice] = "You have updated book successfully."# サクセスメッセージを表示
      redirect_to book_path(@book.id)# 投稿詳細画面へ遷移
    else# でなければ
      render :edit# その本の編集画面へ遷移
    end
  end

  def destroy
    book = Book.find(params[:id])#データ(レコード)を1件取得
    book.destroy#データ（レコード）を削除
    redirect_to '/books'# 一覧画面へ遷移させたい
  end

  private

  def book_params#  データベースからデータを取得
    params.require(:book).permit(:title, :body)
  end
end
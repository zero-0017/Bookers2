class UsersController < ApplicationController
  def index
    @user = current_user# 現在ログインしているユーザーの情報を取得できるメソッド
    @users = User.all#データ(レコード)を全て取得
    @book = Book.new# 新規投稿
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books#ユーザー（自分）に関連している本の投稿が羅列されるように
    @book = Book.new# 新規投稿
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user# 現在ログインしているユーザーかどうか
      render :edit# ユーザー（自分）の編集画面へ遷移
    else# でなければ
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])# どれ（ユーザー）をを更新するのかを指定
    if @user.update(user_params)# もし更新ができたら
      flash[:notice] = "You have updated user successfully."# サクセスメッセージを表示
      redirect_to user_path(@user.id)# ユーザー（自分）の詳細画面へ遷移
    else# でなければ
      render :edit# ユーザー（自分）の編集画面へ遷移
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end

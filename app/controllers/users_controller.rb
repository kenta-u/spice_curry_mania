class UsersController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
      flash[:warning] = t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def edit 
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to root_path
      flash[:warning] = t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @recipes = @user.recipes.order('updated_at DESC').page(params[:page])
  end

  def favorites
    @favorite_recipes = current_user.favorite_recipes.includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end

class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user, only: %i[edit update show]
  before_action :verify_access, only: %i[edit update]
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

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to root_path
      flash[:warning] = t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit
    end
  end

  def show
    @recipes = @user.recipes.order('updated_at DESC').page(params[:page])
  end

  def favorites
    @favorite_recipes = current_user.favorite_recipes.includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def verify_access
    redirect_to root_path, danger: "そのページにはアクセスできません" unless @current_user == @user
  end
end

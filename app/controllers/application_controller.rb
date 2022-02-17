class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  before_action :set_search
  before_action :require_login
  skip_before_action :require_login, only: [:set_serach]

  def set_search
    @search = Recipe.ransack(params[:q])
    @search_recipes = @search.result
    @search_recipes = @search_recipes.order(created_at: :desc).page(params[:page])
  end

  protected

  def not_authenticated
    redirect_to main_app.login_path, danger: "ログインが必要です"
  end
end

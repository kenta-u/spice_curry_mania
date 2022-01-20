class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  before_action :set_search

  def set_search
    @search = Recipe.ransack(params[:q])
    @search_recipes = @search.result
    @search_recipes = @search_recipes.page(params[:page])
  end

  protected

  def not_authenticated
    redirect_to login_path
  end
end

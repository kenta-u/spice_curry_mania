class FavoritesController < ApplicationController
  before_action :require_login

  def create
    recipe = Recipe.find(params[:recipe_id])
    current_user.favorite(recipe)
    redirect_back fallback_location: root_path
  end

  def destroy
    recipe = current_user.favorites.find(params[:id]).recipe
    current_user.unfavorite(recipe)
    redirect_back fallback_location: root_path
  end
end

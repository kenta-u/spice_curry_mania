class RecipesController < ApplicationController
  before_action :require_login
  before_action :set_recipe, only: %i[show edit update destroy]
  skip_before_action :require_login, only: [:index, :show]

  def index
    @recipes = Recipe.all.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @recipe = Recipe.new
    @ingredient = @recipe.ingredients.build
    @spice = @recipe.spices.build
    @step = @recipe.steps.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to root_path
      flash[:warning] = t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def edit; end

  def update
    if @recipe.update(recipe_params)
      redirect_to root_path
      flash[:warning] = t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit
    end
  end

  def show; end

  def destroy
    @recipe.destroy
    redirect_to root_path, warning: t('.success')
  end

  private

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :survings, :category, :image, ingredients_attributes: [:id, :name, :quantity, :_destroy], spices_attributes: [:id, :name, :quantity, :classification, :_destory], steps_attributes: [:id, :direction, :image, :_destroy])
  end
end

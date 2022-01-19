class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.includes(:user).page(params[:page])
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

  def edit
    @recipe = Recipe.find_by(id: params[:id])
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe.update(recipe_params)
      redirect_to root_path
      flash[:warning] = t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit
    end
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :survings, :category, :image, ingredients_attributes: [:id, :name, :quantity, :_destroy], spices_attributes: [:id, :name, :quantity, :classification, :_destory], steps_attributes: [:id, :direction, :image, :_destroy])
  end
end

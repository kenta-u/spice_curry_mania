class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.includes(:user)
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
      flash[:notice] = 'レシピを作成しました'
    else
      flash.now[:alert] = 'レシピの作成に失敗しました'
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
      flash[:notice] = "レシピを編集しました"
    else
      flash.now[:alert] = "レシピの編集に失敗しました"
      render :edit
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :survings, :category, :image, ingredients_attributes: [:id, :name, :quantity, :_destroy], spices_attributes: [:id, :name, :quantity, :classification, :_destory], steps_attributes: [:id, :direction, :image, :_destroy])
  end
end

class CompetitionsController < ApplicationController
  before_action :set_competition, only: %i[show edit update destroy]

  def index
    @competitions = Competition.all
  end

  def show
  end

  def new
    @competition = Competition.new
  end

  def create
    @competition = Competition.new(competition_params)
    if @competition.save
      flash[:notice] = "Змагання створено успішно!"
      redirect_to @competition
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @competition.update(competition_params)
      flash[:notice] = "Змагання оновлено!"
      redirect_to @competition
    else
      render :edit
    end
  end

  def destroy
    @competition = Competition.find(params[:id])
    @competition.destroy
    flash[:notice] = "Змагання видалено."
    redirect_to competitions_path
  end

  private

  def set_competition
    @competition = Competition.find(params[:id])
  end

  def competition_params
    params.require(:competition).permit(:name)
  end
end
class MatieresController < ApplicationController
  def index
    @matieres = Matiere.all
  end

  def show
    @matiere = Matiere.find(params[:id])
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end

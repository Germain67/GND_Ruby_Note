class MatieresController < ApplicationController
  def index
    @matieres = Matiere.all
  end
 
  def show
    @matiere = Matiere.find(params[:id])
  end
 
  def new
    @matiere = Matiere.new
  end
 
  def edit
    @matiere = Matiere.find(params[:id])
  end
 
  def create
    @matiere = Matiere.new(matiere_params)
 
    if @matiere.save
      redirect_to @matiere
    else
      render 'new'
    end
  end
 
  def update
    @matiere = Matiere.find(params[:id])
 
    if @matiere.update(matiere_params)
      redirect_to @matiere
    else
      render 'edit'
    end
  end
 
  def destroy
    @matiere = Matiere.find(params[:id])
    @matiere.destroy
 
    redirect_to matieres_path
  end
 
  private
    def matiere_params
      params.require(:matiere).permit(:title, :text)
    end
end

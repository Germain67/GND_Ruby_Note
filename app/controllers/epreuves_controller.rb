class EpreuvesController < ApplicationController
  
  def index
    @epreuves = Epreuve.all
  end
 
  def show
    @epreuve = Epreuve.find(params[:id])
  end
 
  def new
    @epreuve = Epreuve.new
  end
 
  def edit
    @epreuve = Epreuve.find(params[:id])
  end
 
  def create
    @epreuve = Epreuve.new(epreuve_params)
 
    if @epreuve.save
      redirect_to @epreuve
    else
      render 'new'
    end
  end
 
  def update
    @epreuve = Epreuve.find(params[:id])
 
    if @epreuve.update(epreuve_params)
      redirect_to @epreuve
    else
      render 'edit'
    end
  end
 
  def destroy
    @epreuve = Epreuve.find(params[:id])
    @epreuve.destroy
 
    redirect_to epreuves_path
  end
 
end

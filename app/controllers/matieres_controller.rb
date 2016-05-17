class MatieresController < ApplicationController
  def index
    @matieres = Matiere.all
  end
 
  def show
    if params[:id]
      if user_signed_in?
        ability  = Ability.new(current_user)
        if ability.can? :view, Matiere
          @matiere = Matiere.find(params[:id])
        else
          render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
        end
      else
        render(:file => File.join(Rails.root, 'public/not_sign_in.html'), :layout => false)
      end
    end
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
  end
 
  private
    def matiere_params
      params.require(:matiere).permit(:title, :text)
    end
end

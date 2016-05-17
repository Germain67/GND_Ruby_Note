class EpreuvesController < ApplicationController
  
  def index
    if user_signed_in?
      ability  = Ability.new(current_user)
      if ability.can? :view, Epreuve
        @epreuves = Epreuve.all
      else
        flash[:error] = "Vous n'avez pas le droit de consulter la liste des épreuves"
        redirect_to root_path
      end
    else
      flash[:error] = "Vous devez vous connecter pour consulter la liste des épreuves"
      redirect_to root_path
    end
  end
 
  def show
    if params[:id]
      if user_signed_in?
        ability  = Ability.new(current_user)
        if ability.can? :view, Epreuve
          @epreuve = Epreuve.find(params[:id])
        else
          render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
        end
      else
        render(:file => File.join(Rails.root, 'public/not_sign_in.html'), :layout => false)
      end
    end
  end
 
  def new
    @epreuve = Epreuve.new
  end
 
  def edit
    @epreuve = Epreuve.find(params[:id])
  end
 
  def create
    if user_signed_in?
      ability  = Ability.new(current_user)
      if ability.can? :manage, Epreuve
        @epreuve = Epreuve.new(epreuve_params)
 
        if @epreuve.save
          flash[:success] = "Epreuve créée avec succès."
          redirect_to epreuves_path
        else
          flash[:error] = "Erreur lors de la création de l'épreuve."
          redirect_to new_epreufe_path
        end
      else
        flash[:error] = "Vous n'avez pas le droit de créer d'épreuve"
        redirect_to epreuves_path
      end
    else
      render(:file => File.join(Rails.root, 'public/not_sign_in.html'), :layout => false)
    end
  end
 
  def update
    if user_signed_in?
      ability  = Ability.new(current_user)
      if ability.can? :manage, Epreuve
        @epreuve = Epreuve.find(params[:id])
 
        if @epreuve.update_attributes(epreuve_params)
          flash[:success] = "Epreuve modifiée avec succès."
          redirect_to epreuves_path
        else
          flash[:error] = "Erreur lors de la modification de l'épreuve."
          redirect_to edit_epreufe_path(@epreuve)
        end
      else
        flash[:error] = "Vous n'avez pas le droit de modifier d'épreuve"
        redirect_to epreuves_path
      end
    else
      render(:file => File.join(Rails.root, 'public/not_sign_in.html'), :layout => false)
    end
  end
 
  def destroy
    @epreuve = Epreuve.find(params[:id])
    @epreuve.destroy
 
    redirect_to epreuves_path
  end

  private
    def epreuve_params
      params.require(:epreuve).permit(:titre, :date_examen)
    end
 
end

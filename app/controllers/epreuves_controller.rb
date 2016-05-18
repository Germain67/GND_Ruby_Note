class EpreuvesController < ApplicationController
  
  before_action :verif_pending
  before_action :verif_signin

  # on vérifie avant toute chose que l'user n'est pas un pending, si c'est le cas, on le redirige à la page d'accueil
  def verif_pending
    if user_signed_in?
      if current_user.has_role? :pending
        flash[:error] = "Votre compte est en attente d'approbation par un administrateur. Vous ne pouvez pas accéder aux épreuves"
        redirect_to root_path
      end
    end
  end

  def verif_signin
    if !user_signed_in?
        flash[:error] = "Vous n'êtes pas connecté"
        redirect_to root_path
    end
  end

  ################################## méthodes avec vues

  def index
    ability  = Ability.new(current_user)
    if ability.can? :view, Epreuve
      @epreuves = Epreuve.all
    else
      flash[:error] = "Vous n'avez pas le droit de consulter la liste des épreuves"
      redirect_to root_path
    end
  end
 
  def show
    ability  = Ability.new(current_user)
    if ability.can? :view, Epreuve
      @epreuve = Epreuve.find(params[:id])
    else
      flash[:error] = "Vous n'avez pas le droit de consulter cette épreuve"
      redirect_to epreuves_path
    end

  end
 
  def new
    @epreuve = Epreuve.new
  end
 
  def edit
    @epreuve = Epreuve.find(params[:id])
  end
 
  def create
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
  end
 
  def update
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

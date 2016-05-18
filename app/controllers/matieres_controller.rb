class MatieresController < ApplicationController

  before_action :verif_pending
  before_action :verif_signin

  # on vérifie avant toute chose que l'user n'est pas un pending, si c'est le cas, on le redirige à la page d'accueil
  def verif_pending
    if user_signed_in?
      if current_user.has_role? :pending
        flash[:error] = "Votre compte est en attente d'approbation par un administrateur. Vous ne pouvez pas accéder aux matières"
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
    if ability.can? :view, Matiere
      @matieres = Matiere.all
    else
      flash[:error] = "Vous n'avez pas le droit de consulter la liste des matières"
      redirect_to root_path
    end
  end
 
  def show
    ability  = Ability.new(current_user)
    if ability.can? :view, Matiere
      @matiere = Matiere.find(params[:id])
    else
      flash[:error] = "Vous n'avez pas le droit de consulter cette épreuve"
      redirect_to matieres_path
    end
  end
 
  def new
    @matiere = Matiere.new
  end
 
  def edit
    @matiere = Matiere.find(params[:id])
  end
 
  def create
    ability  = Ability.new(current_user)
    if ability.can? :manage, Matiere
      @matiere = Matiere.new(matiere_params)

      if @matiere.save
        flash[:success] = "Matière créée avec succès."
        redirect_to matieres_path
      else
        flash[:error] = "Erreur lors de la création de la matière."
        redirect_to new_matiere_path
      end
    else
      flash[:error] = "Vous n'avez pas le droit de créer de matière"
      redirect_to matieres_path
    end
  end
 
  def update
    ability  = Ability.new(current_user)
    if ability.can? :manage, Matiere
      @matiere = Matiere.find(params[:id])

      if @matiere.update_attributes(matiere_params)
        flash[:success] = "Matière modifiée avec succès."
        redirect_to matieres_path
      else
        flash[:error] = "Erreur lors de la modification de la matière."
        redirect_to edit_matiere_path(@matiere)
      end
    else
      flash[:error] = "Vous n'avez pas le droit de modifier de matière"
      redirect_to matieres_path
    end
  end
 
  def destroy
    ability  = Ability.new(current_user)
    if ability.can? :manage, Matiere
      @matiere = Matiere.find(params[:id])
      if @matiere.destroy
        flash[:success] = "Matière supprimée avec succès."
        redirect_to matieres_path
      else
        flash[:error] = "Erreur lors de la suppression de la matière."
        redirect_to edit_matiere_path(@matiere)
      end
    else
      flash[:error] = "Vous n'avez pas le droit de supprimer de matière"
      redirect_to matieres_path
    end
  end
 
  private
    def matiere_params
      params.require(:matiere).permit(:titre, :date_debut, :date_fin)
    end
end

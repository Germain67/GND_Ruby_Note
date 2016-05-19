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
      if current_user.has_role? :etudiant
        # Un élève ne peut voir que les épreuves où il a participé, pas les autres.
        @epreuves = Array.new
        @notations = Notation.where("user_id = '"+current_user.id.to_s+"'")
        @notations.each do |notation|
          epreuve = Epreuve.find(notation.epreuve_id)
          epreuve.note = notation.note
          matiere = Matiere.find(epreuve.matiere_id)
          epreuve.titre_matiere = matiere.titre
          @epreuves.push(epreuve)
        end
      elsif current_user.has_role? :enseignant
        # Un enseignant ne peut voir que les épreuves de ses matières.
        @epreuves = Array.new
        @notations = Notation.where("user_id = '"+current_user.id.to_s+"'")
        @notations.each do |notation|
          epreuve = Epreuve.find(notation.epreuve_id)
          epreuve.note = notation.note
          matiere = Matiere.find(epreuve.matiere_id)
          epreuve.titre_matiere = matiere.titre
          @epreuves.push(epreuve)
        end
      else
        # Un admin peut voir toutes les épreuves
        @epreuves = Array.new
        Epreuve.all.each do |epreuve|
          matiere = Matiere.find(epreuve.matiere_id)
          epreuve.titre_matiere = matiere.titre
          @epreuves.push(epreuve)
        end
      end
    else
      flash[:error] = "Vous n'avez pas le droit de consulter la liste des épreuves"
      redirect_to root_path
    end
  end
 
  def show
    ability  = Ability.new(current_user)
    if ability.can? :view, Epreuve
      @epreuve = Epreuve.find(params[:id])
      @matiere = Matiere.find(@epreuve.matiere_id)
    else
      flash[:error] = "Vous n'avez pas le droit de consulter cette épreuve"
      redirect_to epreuves_path
    end

  end
 
  def new
    @epreuve = Epreuve.new
    @listeMatieres = Matiere.all
  end
 
  def edit
    @epreuve = Epreuve.find(params[:id])
    @listeMatieres = Matiere.all
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
    ability  = Ability.new(current_user)
    if ability.can? :manage, Epreuve
      @epreuve = Epreuve.find(params[:id])
      if @epreuve.destroy
        flash[:success] = "Épreuve supprimée avec succès."
        redirect_to epreuves_path
      else
        flash[:error] = "Erreur lors de la suppression de l'épreuve."
        redirect_to edit_epreufe_path(@epreuve)
      end
    else
      flash[:error] = "Vous n'avez pas le droit de supprimer d'épreuve'"
      redirect_to epreuves_path
    end
  end

  private
    def epreuve_params
      params.require(:epreuve).permit(:titre, :date_examen, :matiere_id)
    end
 
end

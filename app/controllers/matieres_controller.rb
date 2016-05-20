class MatieresController < ApplicationController

  before_action :verif_pending
  before_action :verif_signin
  before_action :verif_can_manage, only: [:new, :validate_add, :remove_etudiant, :create, :update, :destroy] 
  before_action :verif_can_view, only: [:show, :index] 

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

  def verif_can_manage
    ability = Ability.new(current_user)
    if !ability.can? :manage, Matiere
        redirect_to matieres_path
      flash[:error] = "Vous n'avez pas la permission de réaliser cette action."
    end
  end

  def verif_can_view
    ability = Ability.new(current_user)
    if !ability.can? :view, Matiere
        redirect_to matieres_path
      flash[:error] = "Vous n'avez pas la permission de réaliser cette action."
    end
  end
  ################################## méthodes avec vues

  def index
    ability  = Ability.new(current_user)
    if current_user.has_role? "admin"
      @matieres = Matiere.all
    else
      @matieres = Array.new
      @appartenances = Appartenance.where("user_id = '"+current_user.id.to_s+"'")
      @appartenances.each do |appartenance|
        matiere = Matiere.find(appartenance.matiere_id)
        @matieres.push(matiere)
      end
    end
  end
 
  def show
    @matiere = Matiere.find_by_id(params[:id])
    if @matiere
      authorizeduser = false
      @appartenances = Appartenance.where("matiere_id = '"+ params[:id] +"'")
      @appartenances.each do |appartenance|
        if appartenance.user_id == current_user.id
          authorizeduser = true
        end
      end
      if authorizeduser
        @users = Array.new
        @appartenances.each do |appartenance|
          user = User.find(appartenance.user_id)
          @users.push(user)
        end
      else
        flash[:error] = "Vous n'êtes pas inscrit à cette matière."
        redirect_to matieres_path 
      end
    else
      flash[:error] = "La matière à laquelle vous essayez d'accéder n'existe pas."
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
    @matiere = Matiere.new(matiere_params)

    if @matiere.save
      flash[:success] = "Matière créée avec succès."
      appartenance = Appartenance.new 
      appartenance.user_id = current_user.id 
      appartenance.matiere_id = @matiere.id 
      appartenance.save!
      redirect_to matieres_path
    else
      flash[:error] = "Erreur lors de la création de la matière."
      redirect_to new_matiere_path
    end
  end
 
  def update
    @matiere = Matiere.find(params[:id])

    if @matiere.update_attributes(matiere_params)
      flash[:success] = "Matière modifiée avec succès."
      redirect_to matieres_path
    else
      flash[:error] = "Erreur lors de la modification de la matière."
      redirect_to edit_matiere_path(@matiere)
    end
  end
 
  def destroy
      @matiere = Matiere.find(params[:id])
      if @matiere.destroy
        flash[:success] = "Matière supprimée avec succès."
        redirect_to matieres_path
      else
        flash[:error] = "Erreur lors de la suppression de la matière."
        redirect_to edit_matiere_path(@matiere)
      end
  end

  def add_etudiant
    @matiere = Matiere.find_by_id(params[:id])
    if @matiere
      @students = Array.new
      @appartenances = Appartenance.where("matiere_id = '"+ params[:id] +"'")
      @appartenances.each do |appartenance|
        student = User.find(appartenance.user_id)
        @students.push(student)
      end
      @newstudents = User.where("id NOT IN (?)", @students)
    else
      flash[:error] = "La matière n'existe pas."
      redirect_to matieres_path
    end
  end

  def validate_add
    @matiere = Matiere.find(params[:matiere_id])
    addeduser = User.find_by_id(params[:user_id])
    if addeduser
      appartenance = Appartenance.new 
      appartenance.user_id = params[:user_id]
      appartenance.matiere_id = params[:matiere_id]
      appartenance.save!
      flash[:success] = "Etudiant ajouté avec succès."
      redirect_to add_etudiant_matiere_path(@matiere)
    else
      flash[:error] = "L'étudiant n'existe pas."
      redirect_to show_matiere_path(@matiere)
    end
  end
 
  def remove_etudiant
    @matiere = Matiere.find_by_id(params[:matiere_id])
    if @matiere
      removeduser = User.find_by_id(params[:user_id])
      if removeduser
        if removeduser.has_role? "etudiant"
          @appartenances = Appartenance.where(matiere_id: params[:matiere_id], user_id: params[:user_id])
          @appartenances.each do |appartenance|
            @appartenance.destroy
          end
          flash[:success] = "Etudiant retiré avec succès."
          redirect_to show_matiere_path(@matiere)
        else
          flash[:error] = "L'utilisateur que vous désirez retirer n'est pas un étudiant."
          redirect_to show_matiere_path(@matiere)
        end
      else
        flash[:error] = "L'étudiant que vous essayez de retirer n'existe pas."
        redirect_to show_matiere_path(@matiere)
      end
      @newstudents = User.where("id NOT IN (?)", @students)
    else
      flash[:error] = "La matière n'existe pas."
      redirect_to matieres_path
    end
  end

  private
    def matiere_params
      params.require(:matiere).permit(:titre, :date_debut, :date_fin)
    end
end

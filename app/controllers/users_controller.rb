class UsersController < ApplicationController
  before_filter :configure_permitted_parameters, if: :devise_controller?

  before_action :verif_pending

  # on vérifie avant toute chose que l'user n'est pas un pending, si c'est le cas, on le redirige à la page d'accueil
  def verif_pending
    if user_signed_in?
      if current_user.has_role? :pending
        flash[:error] = "Votre compte est en attente d'approbation par un administrateur. Vous ne pouvez pas inviter d'étudiants"
        redirect_to root_path
      end
    end
  end

  ################## méthodes du contrôleur

  def manage_all
    ability  = Ability.new(current_user)
    if ability.can? :manage, User
      @users = User.with_any_role(:enseignant, :admin, :etudiant)
      @users.each do |user|
      	user.nom_role = user.roles.first.name
      end

    else
      flash[:error] = "Vous n'avez pas le droit de consulter la liste des utilisateurs"
      redirect_to root_path
    end
  end

  def manage_pending
    ability  = Ability.new(current_user)
    if ability.can? :manage, User
      @users = User.with_role(:pending, :any)
      @users.each do |user|
      	user.nom_role = user.roles.first.name
      end

    else
      flash[:error] = "Vous n'avez pas le droit de consulter la liste des utilisateurs en attente"
      redirect_to root_path
    end
  end

  def accept
    ability  = Ability.new(current_user)
    if ability.can? :manage, User
      @user = User.find(params[:id])
      @user.add_role :enseignant
      @user.remove_role :pending
      flash[:success] = "L'enseignant a été accepté avec succès"
      redirect_to manage_pending_path
    else
      flash[:error] = "Vous n'avez pas le droit d'accepter un enseignant"
      redirect_to root_path
    end
  end

  def show
    ability  = Ability.new(current_user)
    if ability.can? :manage, User
      @user = User.find(params[:id])
      @user.nom_role = @user.roles.first.name
    else
      flash[:error] = "Vous n'avez pas le droit de voir les informations sur cet utilisateur"
      redirect_to root_path
    end

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
      flash[:success] = "Utilisateur supprimé avec succès"
      redirect_to manage_pending_path
    end
  end

  protected

  def configure_permitted_parameters
    # Only add some parameters
    devise_parameter_sanitizer.for(:invite).concat [:nom, :prenom]
  end
end

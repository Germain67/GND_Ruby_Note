class UserController < Devise::InvitationsController
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

  protected

  def configure_permitted_parameters
    # Only add some parameters
    devise_parameter_sanitizer.for(:invite).concat [:nom, :prenom]
  end
end
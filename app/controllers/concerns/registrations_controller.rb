class RegistrationsController < Devise::RegistrationsController





  protected

  def user_params
    accessible = [
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    ]
    params.require(:user).permit(accessible)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end



end


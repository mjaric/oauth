class RegistrationsController < Devise::RegistrationsController

  def update
    @user = User.find(current_user.id)
    #raise params[:user].to_yaml
    # In case that user don't have authorizations added, need to provide confirm password
    successfully_updated = if @user.needs_password?
      @user.update_with_password(params[:user])
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      params[:user].delete(:current_password)
      # @user.update_without_password(params[:user])
      @user.update_attributes(params[:user])
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  private

  def build_resource(*args)
    super
    #raise session[:omniauth].to_yaml
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    user.authentications.empty?
  end

end
class Admin::AdminController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  helper_method :sort_column, :sort_direction

  def current_ability
    @current_ability ||= AdminAbility.new(current_user)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :flash => { :error => exception.message }
  end

  private

  def sort_column
    logger.debug('model_class')
    controller_name.singularize.classify.constantize.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

end

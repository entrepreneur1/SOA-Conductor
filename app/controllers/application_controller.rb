class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_admin?
    current_user && Admin >= current_user.class
  end

  def is_doctor?
    current_user && DoctorUser >= current_user.class
  end

  def is_patient?
    current_user && PatientUser >= current_user.class
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to access this section."
      redirect_to log_in_path
    end
  end

  def logged_in?
    !!current_user
  end

  def requires_admin
    unless is_admin?
      flash[:error] = "You must be admin to acccess this section."
      redirect_to root_path
    end
  end

  def user_role
    return 'Patient' if is_patient?
    return 'Doctor' if is_doctor?
    return 'Admin' if is_admin?
    'Unknown'
  end

  helper_method :requires_admin, :is_admin?, :is_patient?, :is_doctor?, :require_login, :current_user, :logged_in?, :user_role

end

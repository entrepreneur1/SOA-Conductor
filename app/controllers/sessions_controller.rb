class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    respond_to do |format|
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        format.html {
          redirect_to root_url, :notice => "Logged in!"
        }
        format.json {
          render :json => "OK".to_json
        }
      else
        flash.now.alert = "Invalid email or password"
        format.html {
          render "new"
        }
        format.json {
          render :json => "FAIL".to_json
        }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

  def new

  end
end

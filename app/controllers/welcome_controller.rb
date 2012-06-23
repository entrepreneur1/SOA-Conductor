class WelcomeController < ApplicationController
  def index
    respond_to do |format|
      format.html {
      @specializations = SpecializationExt.all
      }
      format.json {
        render :json => current_user.to_json
      }
    end
  end
end

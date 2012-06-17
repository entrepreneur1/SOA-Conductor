class WelcomeController < ApplicationController
  def index
    @specializations = Specialization.all
  end
end

class Reservation < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor

  def title
    "rezerwacja"
  end




  #def to_json
  #  super :methods => :title
  #end

end

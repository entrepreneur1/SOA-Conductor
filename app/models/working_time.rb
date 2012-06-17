class WorkingTime < ActiveRecord::Base
  belongs_to :doctor

  def title
    "Working hours"
  end
end

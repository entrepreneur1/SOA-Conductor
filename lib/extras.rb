class String
  def is_numeric?
    begin
      Float(self)
      true
    end
  rescue
    false
  end

  def is_integer?
    begin
      Integer(self)
      true
    end
  rescue
    false
  end

end



module Extras

end
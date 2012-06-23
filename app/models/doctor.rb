class Doctor < ActiveRecord::Base
  belongs_to :clinic
  has_many :ratings
  has_many :reservations
  has_many :working_times
  belongs_to :specialization
  belongs_to :doctor_user, :foreign_key => 'user_id'

  validates_associated :clinic

  def full_name
    "#{name} #{surname}"
  end

  def city
    clinic.address.city rescue nil
  end

  def working_hours_at(date)
    time = working_times.find_by_day(date.wday)
    time.start = time.start.change(year: date.year, month: date.month, day: date.day )
    time.end = time.end.change(year: date.year, month: date.month, day: date.day )
    time
  end

  def recalculate_rating
    sum = ratings.inject(0){ |s,rating| s += rating.rate }
    update_attribute :avg_rating, Float(sum)/ratings.size
  end

  def self.search(search)               # TODO do przepisania na scope'y
    scope = scoped
    if search
      if search[:sort].present? and search[:direction].present?
        search[:sort].downcase!
        case search[:sort]
          when 'clinic'
            scope = scoped(:include => :clinic)
            search[:sort] = 'clinics.name'
          when 'specialization'
            scope = scoped(:include => :specialization)
            search[:sort] = 'specializations.name'
          when 'city'
            scope = scoped(:include => [{:clinic => :address}])
            search[:sort] = 'addresses.city'
          when 'visit duration'
            search[:sort] = 'visit_duration'
          when 'rating'
            search[:sort] = 'avg_rating'
        end
        scope = scope.order(search[:sort] + " " + search[:direction])
      end
      unless search[:name].blank?
        puts search[:name]
        scope = scope.where('lower(surname) LIKE ?', "%#{search[:name].downcase}%")
      end
      if search[:specialization].present? and search[:specialization].is_integer?
        scope = scope.select { |doc| doc.specialization_id == Integer(search[:specialization])}
      end
      unless search[:clinic].blank?
        scope = scope.select { |doc| doc.clinic.try(:name) =~ /#{search[:clinic]}/i }
      end
      unless search[:city].blank?
        scope = scope.select { |doc| doc.city =~ /#{search[:city]}/i }
      end
      if search[:min_duration].present? and search[:min_duration].is_numeric?
        scope = scope.select { |doc| (doc.visit_duration || 9999) >= Float(search[:min_duration]) }
      end
      if search[:max_duration].present? and search[:max_duration].is_numeric?
        scope = scope.select { |doc| (doc.visit_duration || 9999) <= Float(search[:max_duration]) }
      end

    end
    scope
  end

end

class Specialization < ActiveRecord::Base
  has_many :doctors
  validates_uniqueness_of :name

  default_scope :order => 'name'
end

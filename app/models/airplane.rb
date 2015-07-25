class Airplane < ActiveRecord::Base
  validates :registration_number, uniqueness: { case_sensitive: false }
  validates_presence_of :model_name, :registration_number
  has_many :flights
end

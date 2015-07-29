class Airplane < ActiveRecord::Base
  validates :registration_number, uniqueness: { case_sensitive: false }
  validates_presence_of :model_name, :registration_number
  validates :model_name, length: { in: 2..100 }
  validates :registration_number, length: { in: 6..30 }
  has_many :flights

  self.per_page = AIRPLANES_PER_PAGE
end

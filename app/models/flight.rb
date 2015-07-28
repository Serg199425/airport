class Flight < ActiveRecord::Base
  extend Enumerize
  enumerize :status, in: [:waiting, :in_progress, :ended]
  belongs_to :airplane
  validates_presence_of :airplane, :take_off_start_time
  validates :take_off_end_time, uniqueness: true, allow_blank: true

  self.per_page = FLIGHTS_PER_PAGE

  after_save :update_flights
  after_destroy :update_flights

  def update_flights
    WebsocketRails[:flights].trigger 'update' if self.status
  end
end

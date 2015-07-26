class Flight < ActiveRecord::Base
  extend Enumerize
  enumerize :status, in: [:takes_off, :took_off]
  belongs_to :airplane
  validates_presence_of :airplane, :takes_of_start_time
  after_create :update_flights

  self.per_page = FLIGHTS_PER_PAGE
  def update_flights
    WebsocketRails[:flights].trigger 'update'
  end
end

class FlightsStatusWorker
  include Sidekiq::Worker

  def perform()
    ended_flights = Flight.where('status IN (?) AND take_off_end_time < ?', [:waiting, :in_progress], Time.now.utc)
    ended_flights.update_all(status: :ended)

    in_progress_flights = Flight.where('status = ? AND take_off_start_time < ? AND ? < take_off_end_time', :waiting, Time.now.utc, Time.now.utc)
    in_progress_flights.update_all(status: :in_progress)

    WebsocketRails[:flights].trigger 'update'
    puts "Flights Statuses is Updated"
  end
end
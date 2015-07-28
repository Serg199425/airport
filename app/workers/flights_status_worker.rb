class FlightsStatusWorker
  include Sidekiq::Worker

  def perform()
    ended_flights = Flight.where('status IN (?) AND take_off_end_time < ?', [:waiting, :in_progress], Time.now.utc)
    in_progress_flights = Flight.where('status = ? AND take_off_start_time < ? AND ? < take_off_end_time', :waiting, Time.now.utc, Time.now.utc) 

    if ended_flights.present? || in_progress_flights.present?
      ended_flights.update_all(status: :ended) if ended_flights.present?
      in_progress_flights.update_all(status: :in_progress) if in_progress_flights.present?
      WebsocketRails[:flights].trigger 'update' 
      puts "Flights Statuses is Updated"
    else
      puts "Flights Statuses is not Changed"
    end

    FlightsStatusWorker.perform_in(UPDATE_FLIGHTS_STATUSES_INTERVAL)
  end
end
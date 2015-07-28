class FlightsWorker
  include Sidekiq::Worker

  def perform(new_flight_id)
    new_flight = Flight.find_by(id: new_flight_id)
    return if new_flight.blank?
    take_off_duration = random_take_off_duration
    flights = Flight.where('take_off_end_time > ?', new_flight.take_off_start_time)
    start_time = new_flight.take_off_start_time

    flights.each do |flight|
      end_time = flight.take_off_start_time
      break if end_time - start_time >= take_off_duration
      start_time = flight.take_off_end_time
    end

    new_flight.take_off_start_time = start_time
    new_flight.take_off_end_time = start_time + take_off_duration
    new_flight.status = :waiting
    puts new_flight.save ? "flight is added with ID #{new_flight.id}" : "flight is not added"
  end

  def random_take_off_duration
    TAKE_OFF_MIN_TIME + TAKE_OFF_MIN_TIME * rand
  end
end
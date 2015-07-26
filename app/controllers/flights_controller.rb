class FlightsController < ApplicationController
  autocomplete :airplane, :registration_number, :limit => 10

  def index
    @flights = Flight.where(status: [:waiting, :in_progress]).order('take_off_end_time asc').includes(:airplane).paginate(:page => params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @flight = Flight.new
    if request.post?
      @flight.airplane = Airplane.find_by(registration_number: params[:registration_number])
      @flight.take_off_start_time = params[:flight][:take_off_start_time].to_datetime
      if @flight.save
        FlightsWorker.perform_in(5.seconds, @flight.id)
        redirect_to action: :index
      end
    end
  end
end

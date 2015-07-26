class FlightsController < ApplicationController
  autocomplete :airplane, :registration_number, :limit => 10

  def index
    @flights = Flight.order('takes_of_end_time asc').paginate(:page => params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    if request.post?
      @flight = Flight.new
      @flight.airplane = Airplane.find_by(registration_number: params[:registration_number])
      @flight.takes_of_start_time = params[:flight][:takes_of_start_time].to_datetime
      redirect_to action: :index if @flight.save
    else
      @flight = Flight.new
    end
  end
end

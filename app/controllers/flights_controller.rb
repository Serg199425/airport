class FlightsController < ApplicationController
  before_action :authenticate_user!
  def index
    respond_to do |format|
      format.html
      format.js {
        @flights = Flight.where(status: [:waiting, :in_progress]).order('take_off_end_time asc')
          .includes(:airplane).paginate(:page => params[:page])
      }
    end
  end

  def history
    respond_to do |format|
      format.html
      format.js {
        @flights = Flight.where(status: :ended).order('take_off_end_time asc')
          .includes(:airplane).paginate(:page => params[:page])
        render 'index.js'
      }
    end
  end

  def create
    @flight = Flight.new
    if request.post?
      @flight.airplane = Airplane.find_by(registration_number: params[:registration_number])
      @flight.take_off_start_time = params[:flight][:take_off_start_time].to_datetime
      if @flight.save
        FlightsWorker.perform_async(@flight.id)
        redirect_to action: :index
      end
    end
  end

  def autocomplete_airplane
    term = params[:term]
    airplanes = Airplane.where('registration_number LIKE ? OR model_name LIKE ?', "%#{term}%", "%#{term}%").order(:registration_number)
    render :json => airplanes.map { |airplane| {:id => airplane.id, :label => airplane.model_name.to_s + " " + airplane.registration_number.to_s, :value => airplane.registration_number} }
  end
end

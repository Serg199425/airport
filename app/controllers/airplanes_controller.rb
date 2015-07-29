class AirplanesController < ApplicationController
  before_action :authenticate_user!

  def index
    @airplanes = Airplane.all.paginate(:page => params[:page])
  end

  def show
    @airplane = Airplane.find_by(id: params[:id])
    @flights = Flight.where(airplane: @airplane).order('take_off_end_time asc').paginate(:page => params[:page]) if @airplane
  end

  def search 
    @airplane = Airplane.find_by(registration_number: params[:registration_number])
    @flights = Flight.where(airplane: @airplane).order('take_off_end_time asc').paginate(:page => params[:page]) if @airplane
    render 'show'
  end

  def autocomplete_airplane
    term = params[:term]
    airplanes = Airplane.where('registration_number LIKE ? OR model_name LIKE ?', "%#{term}%", "%#{term}%")
                  .order(:registration_number).limit(10)
    render :json => airplanes.map { |airplane| {:id => airplane.id, :label => airplane.model_name.to_s + " " + 
                                    airplane.registration_number.to_s, :value => airplane.registration_number} }
  end
end

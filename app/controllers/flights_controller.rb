class FlightsController < ApplicationController
  before_action :set_flight, only: %i[show edit update destroy print]

  def index
    @flights = Flight.all
  end

  def show; end

  def new
    @flight = Flight.new
  end

  def edit; end

  def create
    @flight = Flight.new(flight_params)

    if @flight.save
      redirect_to @flight, notice: 'Flight was successfully created.'
    else
      render :new
    end
  end

  def update
    if @flight.update(flight_params)
      redirect_to @flight, notice: 'Flight was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @flight.destroy
    redirect_to flights_url, notice: 'Flight was successfully destroyed.'
  end

  def print
    mdc = MissionDataCard.new @flight
    send_data mdc.render, filename: "mission_#{@flight.id}.pdf", type: 'application/pdf', disposition: :inline
  end

  private

  def set_flight
    @flight = Flight.find(params[:id])
  end

  def flight_params
    params.require(:flight).permit(:theater, :airframe, :start, :duration, :callsign, :callsign_number, :slots, :mission, :objectives, :group_id, :laser, :tacan_channel, :tacan_polarization, :frequency, :notes, :start_airbase, :land_airbase, :divert_airbase, :departure, :arrival)
  end
end
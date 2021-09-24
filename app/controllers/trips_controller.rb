class TripsController < ApplicationController
  def destroy
    trip = Trip.find(params[:id])
    trip.destroy
    redirect_to flights_path
  end
end

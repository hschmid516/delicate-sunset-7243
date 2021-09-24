class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights
  # has_many :trips, through: :flights

  def sorted_adult_passengers
    flights.joins(:trips, :passengers)
           .select('passengers.*, COUNT(trips) as flight_count')
           .where('passengers.id = trips.passenger_id')
           .where('age > 17')
           .group('passengers.id')
           .order(flight_count: :desc)
  end
end

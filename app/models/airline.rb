class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def sorted_adult_passengers
    flights.joins(:passengers)
           .select('passengers.*, COUNT(flights) as flight_count')
           .where('age > ?', 17)
           .group('passengers.id')
           .order(flight_count: :desc)
  end
end

class Passenger < ApplicationRecord
  has_many :trips
  has_many :flights, through: :trips
  has_many :airlines, through: :flights
end

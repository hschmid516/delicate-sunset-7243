require 'rails_helper'

RSpec.describe Airline do
  describe 'relationships' do
    it { should have_many(:flights) }
    it { should have_many(:passengers).through(:flights) }
  end

  it 'sorts adult passengers for airline' do
    @airline1 = Airline.create!(name: 'Alaska')
    @flight1 = @airline1.flights.create!(number: '1727', date: '08/03/20', departure_city: 'Denver', arrival_city: 'Reno')
    @flight2 = @airline1.flights.create!(number: '200', date: '09/24/21', departure_city: 'Uluwatu', arrival_city: 'Portland')
    @flight3 = @airline1.flights.create!(number: '100', date: '10/24/21', departure_city: 'Vancouver', arrival_city: 'Bangor')
    @pass1 = @flight1.passengers.create(name: 'Henry', age: 30)
    Trip.create!(flight: @flight2, passenger: @pass1)
    @pass2 = @flight1.passengers.create(name: 'Timmy', age: 13)
    @pass3 = @flight2.passengers.create(name: 'Frank', age: 40)
    @pass4 = @flight2.passengers.create(name: 'Nancy', age: 63)
    @pass5 = @flight2.passengers.create(name: 'Ruby', age: 17)
    Trip.create!(flight: @flight2, passenger: @pass4)
    Trip.create!(flight: @flight3, passenger: @pass4)

    @airline2 = Airline.create!(name: 'Southwest')
    @flight4 = @airline2.flights.create!(number: '111', date: '01/01/20', departure_city: 'Honolulu', arrival_city: 'Tokyo')
    @pass6 = @flight4.passengers.create(name: 'Tammy', age: 32)
    Trip.create!(flight: @flight4, passenger: @pass1)

    expect(@airline1.sorted_adult_passengers[0].name).to eq(@pass4.name)
    expect(@airline1.sorted_adult_passengers[1].name).to eq(@pass1.name)
    expect(@airline1.sorted_adult_passengers[2].name).to eq(@pass3.name)
    expect(@airline1.sorted_adult_passengers[3]).to eq(nil)
  end
end

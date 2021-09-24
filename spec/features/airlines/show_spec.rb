require 'rails_helper'

RSpec.describe 'airline show page' do
  before :each do
    @airline1 = Airline.create!(name: 'Alaska')
    @flight1 = @airline1.flights.create!(number: '1727', date: '08/03/20', departure_city: 'Denver', arrival_city: 'Reno')
    @flight2 = @airline1.flights.create!(number: '200', date: '09/24/21', departure_city: 'Uluwatu', arrival_city: 'Portland')
    @pass1 = @flight1.passengers.create(name: 'Henry', age: 30)
    Trip.create!(flight: @flight1, passenger: @pass1)
    @pass2 = @flight1.passengers.create(name: 'Timmy', age: 13)
    @pass3 = @flight2.passengers.create(name: 'Frank', age: 40)
    @pass4 = @flight2.passengers.create(name: 'Nancy', age: 63)
    @pass5 = @flight2.passengers.create(name: 'Ruby', age: 17)

    @airline2 = Airline.create!(name: 'Southwest')
    @flight4 = @airline2.flights.create!(number: '111', date: '01/01/20', departure_city: 'Honolulu', arrival_city: 'Tokyo')
    @pass6 = @flight4.passengers.create(name: 'Tammy', age: 32)
    visit airline_path(@airline1)
  end

  it 'shows all adult passengers for an airline' do
    expect(page).to have_content(@pass1.name, count: 1)
    expect(page).to have_content(@pass3.name)
    expect(page).to have_content(@pass4.name)
    expect(page).to_not have_content(@pass2.name)
    expect(page).to_not have_content(@pass5.name)
  end
end

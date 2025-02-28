require 'rails_helper'

RSpec.describe 'flights index page' do
  before :each do
    @airline = Airline.create!(name: 'Alaska')
    @flight1 = @airline.flights.create!(number: '1727', date: '08/03/20', departure_city: 'Denver', arrival_city: 'Reno')
    @flight2 = @airline.flights.create!(number: '200', date: '09/24/21', departure_city: 'Uluwatu', arrival_city: 'Portland')
    @pass1 = @flight1.passengers.create(name: 'Henry', age: 30)
    @pass2 = @flight1.passengers.create(name: 'Timmy', age: 13)
    @pass3 = @flight2.passengers.create(name: 'Frank', age: 40)
    visit flights_path
  end

  it 'shows all flight numbers, names, passengers' do
    within("#flight-#{@flight1.id}") do
      expect(page).to have_content(@flight1.number)
      expect(page).to have_content(@airline.name)
      expect(page).to have_content(@pass1.name)
      expect(page).to have_content(@pass2.name)
    end

    within("#flight-#{@flight2.id}") do
      expect(page).to have_content(@flight2.number)
      expect(page).to have_content(@airline.name)
      expect(page).to have_content(@pass3.name)
    end
  end

  it 'can remove passenger from flight' do
    within("#flight-#{@flight1.id}") do
      within("#passenger-#{@pass1.id}") do
        click_link('Remove Passenger')
      end
      expect(current_path).to eq(flights_path)
      expect(page).to_not have_content(@pass1.name)
    end

    expect(Passenger.find(@pass1.id)).to eq(@pass1)

    within("#flight-#{@flight2.id}") do
      within("#passenger-#{@pass3.id}") do
        click_link('Remove Passenger')
      end
      expect(current_path).to eq(flights_path)
      expect(page).to_not have_content(@pass3.name)
    end

    expect(Passenger.find(@pass3.id)).to eq(@pass3)
  end
end

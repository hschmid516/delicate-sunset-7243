require 'rails_helper'

RSpec.describe Passenger do
  it { should have_many(:trips) }
  it { should have_many(:flights).through(:trips) }
end

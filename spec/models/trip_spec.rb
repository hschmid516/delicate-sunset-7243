require 'rails_helper'

RSpec.describe Trip do
  it { should belong_to(:passenger) }
  it { should belong_to(:flight) }
end

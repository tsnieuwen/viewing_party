require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe "relationships" do
    it { should have_many :parties }
  end

  describe "validations" do
    it {should validate_presence_of :api_id}
  end
end

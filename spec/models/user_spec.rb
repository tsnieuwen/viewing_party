require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  describe "Callbacks" do
    it "Cleans email to lowercase" do
      user = User.create(email: 'GREAT@example.com', password: '1234')
      expect(user.email).to eq('great@example.com')
    end
  end
end
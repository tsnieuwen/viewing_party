require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  before :each do
    UserParty.destroy_all
    User.destroy_all
    @friend1 = User.create(
      email: 'greatfriend@example.com',
      password: '1223'
    )
    @friend2 = User.create(
      email: 'bestestfriend@example.com',
      password: '4321'
    )
    @friend3 = User.create(
      email: 'friend3@example.com',
      password: 'test'
    )
    @user = User.create(
      email: 'foo@bar.com',
      password: 'test'
    )
    @user.friends << @friend1
    @user.friends << @friend2
    @user.friends << @friend3
  end

  describe 'When I visit the chatroom' do
    it 'It should display my friends' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        visit chat_index_path

        expect(page).to have_content("#{@friend1.email}")
        expect(page).to have_content("#{@friend2.email}")
        expect(page).to have_content("#{@friend3.email}")
    end
  end
end
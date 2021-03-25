require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  before :each do
    @friend1 = User.create(
      email: 'greatfriend@example.com',
      password: '1223'
    )
    friend2 = User.create(
      email: 'bestestfriend@example.com',
      password: '4321'
    )
    @user = User.create(
      email: 'user@example.com',
      password: 'password'
    )
    visit login_path
      fill_in :email, with: 'user@example.com'
      fill_in :password, with: 'password'
      click_button 'Log In'
  end
  
  describe 'I see a section for friends with a text field' do
    it 'Can enter friends email and button to Add Friend' do
      visit root_path
      click_link 'Dashboard'
      
      within(".friends") do
        expect(page).to have_button('Add Friend')
        expect(page).to have_content('You currently have no friends.')
      end
    end

  scenario 'Should see list of friends after adding' do
    visit root_path
    click_link 'Dashboard'

    within(".friends") do
      fill_in :email, with: 'greatfriend@example.com'
      click_button 'Add Friend'
    end

    expect(page).to have_content("You have added greatfriend@example.com as a friend!")
    
    within(".friends") do
      fill_in :email, with: 'bestestfriend@example.com'
      click_button 'Add Friend'
    end

    expect(page).to have_content("You have added bestestfriend@example.com as a friend!")

    expect(current_path).to eq(dashboard_path)
    within(".friends") do
      expect(page).to have_content('greatfriend@example.com')
      expect(page).to have_content('bestestfriend@example.com')
    end
    end

    scenario 'When the friend doesnt exist theyre not shown' do
      visit root_path
      click_link 'Dashboard'

      within(".friends") do
        fill_in :email, with: 'newfriend@example.com'
        click_button 'Add Friend'
      end

      expect(page).to have_content('That user does not exist')
    end
  end
end
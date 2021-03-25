require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  before :each do
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
  end
end





# As an authenticated user,
# I see a section for friends,
# In this section, there should be a text field to enter a 
# friend's email and a button to "Add Friend"

# Scenarios:

# If I have not added any friends there should be a message. 
# "You currently have no friends".

# If I have added friends, I should see a list of all my friends.

# Details: Users should be able to add a friend by their email address, 
# as long as, the friend is a user of our application and exists in our database.

# Example:
# Bugs Bunny and Lola Bunny are users of our application, but Daffy Duck is not.

# When Bugs Bunny enters lola_bunny@gmail.com to add friend 
# it will be successful and Lola should show up as Bugs Bunny's friend.
# When Bugs Bunny enters daffy_duck@gmail.com to add friend 
# it should give an error message that the user does not exist.
# Tips: You'll want to research self-referential has_many through. 
# Here is a good starting point to understand the concept. You will probably need to do more googling but that's part of the fun ;)

#  Write a happy path test
#  Write a sad path test
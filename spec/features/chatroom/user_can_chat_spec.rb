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
    @message1 = @user.messages.create(body: "Ruby is sweet")
    @message2 = @user.messages.create(body: "OOP fo life")
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
      
    it "Should show messages" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit chat_index_path

      expect(page).to have_content(@message1.body)
      expect(page).to have_content(@message2.body)
    end

     it "Should send message" do
       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
       visit chat_index_path

       fill_in "message[body]", with: "Test message"
       click_button 'Send'
       
       expect(current_path).to eq(chat_index_path)
       expect(page).to have_content("Test message")
    end

     it "Should be able to delete messages" do
      Message.destroy_all
       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
       visit chat_index_path

       fill_in "message[body]", with: "Test message"
       click_button 'Send'

       expect(current_path).to eq(chat_index_path)
       expect(page).to have_content("Test message")
       
       click_button 'Delete Message'
       
       expect(current_path).to eq(chat_index_path)
       expect(page).not_to have_content("Test message")
    end
  end
end
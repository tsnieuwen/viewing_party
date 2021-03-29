class ChatController < ApplicationController
  before_action :authorized, only: [:index]
  def index
    @messages = Message.all
  end
end
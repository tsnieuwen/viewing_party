class MessagesController < ApplicationController
  def create
    Message.create(message_params)  
    redirect_to chat_index_path
  end
  
  def destroy
    Message.destroy(params[:id])
    redirect_to chat_index_path
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)  
  end
end
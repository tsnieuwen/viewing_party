class MessagesController < ApplicationController
  def create
    new_message = Message.new(message_params)
    return unless new_message.save

    ActionCable.server.broadcast 'chatroom_channel',
                                 expected: message_render(new_message)
  end

  def destroy
    Message.destroy(params[:id])
    redirect_to chat_index_path
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def message_render(message)
    render(partial: 'message', locals: { message: message })
  end
end

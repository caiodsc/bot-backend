class MessagesController < ApplicationController
  expose :message
  expose :messages, -> { Message.order(created_at: :desc).page(params[:page]).per(15) }

  def index
    render_api(messages)
  end

  def create
    message.save
    render_api(message, :created)
  end

  private

  def message_params
    params.require(:message).permit(:body, :sender)
  end
end

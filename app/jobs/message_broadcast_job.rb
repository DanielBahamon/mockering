class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later
    # ActionCable.server.broadcast "conversation_#{conversation.id}", {	message: render_message(message)  }
  end

  private

  def render_message(message)
  	MessagesController.render(
  		partial: 'message',
  		locals: {
  			message: message
  		}
  	)
  end
end

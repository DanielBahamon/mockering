class MessagesController < ApplicationController
	before_action :authenticate_mocker!
	before_action :set_conversation
	skip_before_action :verify_authenticity_token

	def index
		if current_mocker == @conversation.sender || current_mocker == @conversation.recipient
			@other = current_mocker == @conversation.sender ? @conversation.recipient : @conversation.sender
			@messages = @conversation.messages.order("created_at ASC")
		else
			redirect_to conversations_path, alert: "Opps! It's not your conversation."
		end
	end

	def new
		
	end

	def create
		@message = @conversation.messages.new(message_params)
		@messages = @conversation.messages.order("create_at DESC")
		# @message.save
		if @message.save
			ActionCable.server.broadcast "conversation_#{@conversation.id}", message: render_message(@message)
			# redirect_to conversation_messages_path(@conversation)
		end
	end

	private

	def render_message(message)
		self.render(partial: 'messages/message', locals: {message: message})			
	end

	def set_conversation
		@conversation = Conversation.find(params[:conversation_id])
	end

	def message_params
		params.require(:message).permit(:body, :mocker_id)
	end
end

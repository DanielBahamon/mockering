class TrademarkcontactsController < ApplicationController

	def new
		@contact = Trademarkcontact.new
	end

	def create
		@contact = Trademarkcontact.new(params[:trademarkcontact])
		@contact.request = request
		if @contact.deliver
			flash.now[:error] = nil
		else
			flash.now[:error] = 'Cannot send message.'
			render :new
		end
	end

end

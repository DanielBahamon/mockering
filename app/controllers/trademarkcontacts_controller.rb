class TrademarkcontactsController < ApplicationController
  	before_action :trademarkcontact, only: [:create]
	def new
		@contact = Trademarkcontact.new(params[:trademarkcontact])
	end

	def create
		@contact = Trademarkcontact.new(params[:trademarkcontact])
		@contact.request = request
	    if @contact.deliver
	      flash.now[:notice] = 'Thank you for your message!'
	      render :create
	    else
	      flash.now[:error] = 'Cannot send message.'
	      render :new
	    end
	end

	private

	def trademarkcontact
		params.require(:trademarkcontact).permit(:name, :email, :message, :nickname, :captcha, :title,  :company_name, :relationship_owner,
												 :kind_company, :url, :specification, :i_believe, :i_declare, :i_agree, :fullname)
	end
end

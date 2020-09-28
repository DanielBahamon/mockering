class ForgerycontactsController < ApplicationController
  	before_action :forgerycontact, only: [:create]
	def new
		@contact = Forgerycontact.new(params[:forgerycontact])
	end

	def create
		@contact = Forgerycontact.new(params[:forgerycontact])
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

	def forgerycontact
		params.require(:forgerycontact).permit(:name, :email, :message, :nickname, :captcha, :title,  :company_name, :country,
												 :trademark_name, :url, :business_address, :i_believe, :i_agree, :fullname, :business_website,
												 :trademark, :registration_number, :product_issue, :clarify)
	end
end

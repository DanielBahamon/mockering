class CopyrightcontactsController < ApplicationController
  	before_action :copyrightcontact, only: [:create]
	def new
		@contact = Copyrightcontact.new(params[:copyrightcontact])
	end

	def create
		@contact = Copyrightcontact.new(params[:copyrightcontact])
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

	def copyrightcontact
		params.require(:copyrightcontact).permit(:name, :email, :message, :nickname, :captcha, :title,  :company_name, :relationship_owner,
												 :kind_company, :url, :specification, :i_believe, :i_declare, :i_agree, :fullname)
	end
end

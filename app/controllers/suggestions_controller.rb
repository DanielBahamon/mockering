class SuggestionsController < ApplicationController
  	before_action :suggestion, only: [:create]
	def new
		@contact = Suggestion.new(params[:suggestion])
	end

	def create
		@contact = Suggestion.new(params[:suggestion])
		@contact.request = request

	    if @contact.deliver && verify_recaptcha 
	      flash.now[:notice] = 'Thank you for your suggestion!'
	      render :create
	    else
	      flash.now[:error] = 'Cannot send suggestion.'
	      render :new
	    end
	end

	private

	def suggestion
		params.require(:suggestion).permit(:name, :email, :message, :nickname, :captcha, :title, :kind_suggestions, :i_agree)
	end
end

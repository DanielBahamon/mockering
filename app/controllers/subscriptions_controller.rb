class SubscriptionsController < ApplicationController
	def index
		@subscription = Subscription.new
	end

	def es
		@subscription = Subscription.new
	end

	def show
	end

	def create
		@subscription = Subscription.new(subscription_params)
		if @subscription.save
    	  flash[:notice] = "Great! We will contact you."
		  redirect_back fallback_location: root_path
		else
	      flash[:alert] = "Opps! That e-mail is registered. Please try again."
	      redirect_back fallback_location: root_path
		end
	end

	# def subscriber_validator
	# 	if params[:email].size <= 2
	#   	  render json: { valid: false }
	# 	elsif Subscription.find_by_email(params[:email].downcase)
	# 	  render json: { valid: false }
	# 	else
	# 	  render json: { valid: true }
	# 	end
	# end

	private

    def subscription_params
      params.require(:subscription).permit(:email, :name)
    end
end

class MockersController < ApplicationController

	before_action :authenticate_mocker!, except: [:show, :username_validator]
   	before_action :set_mocker, only: [:show, :edit, :update, :destroy]

	def show
    	@mocker = Mocker.friendly.find(params[:id])
    	@mocks = @mocker.mocks.order("created_at DESC").paginate(page: params[:mocks_page], per_page: 10).where(privated: false)
    	@followers = @mocker.followers.order("created_at DESC").paginate(page: params[:followers_page], per_page: 10)
		@following = @mocker.following.order("created_at DESC").paginate(page: params[:following_page], per_page: 10)
		@privated_mocks = @mocker.mocks.order("created_at DESC").paginate(page: params[:privated_mocks_page], per_page: 10).where(privated: true)
		# @fav_mocks = @mocker.find_up_voted_items
		@fav_mocks = @mocker.get_up_voted Mock

		@reported = MockerReport.where(reported_id: @mocker.id).count
		@reported_0 = MockerReport.where(reported_id: @mocker.id, classification: 0).count
		@reported_1 = MockerReport.where(reported_id: @mocker.id, classification: 1).count
		@reported_2 = MockerReport.where(reported_id: @mocker.id, classification: 2).count
		@reported_3 = MockerReport.where(reported_id: @mocker.id, classification: 3).count
		@reported_4 = MockerReport.where(reported_id: @mocker.id, classification: 4).count
		@reported_5 = MockerReport.where(reported_id: @mocker.id, classification: 5).count
		@reported_6 = MockerReport.where(reported_id: @mocker.id, classification: 6).count

		@appealed_reason_0 = MockerAppeal.where(reported_id: @mocker.id, reason: 0).count
		@appealed_reason_1 = MockerAppeal.where(reported_id: @mocker.id, reason: 1).count
		@appealed_reason_2 = MockerAppeal.where(reported_id: @mocker.id, reason: 2).count
		@appealed_reason_3 = MockerAppeal.where(reported_id: @mocker.id, reason: 3).count

		if @reported > 10
			@mocker.update(reported: true)
		elsif @reported_0 > 5 || @reported_1 > 2 || @reported_2 > 2 || @reported_3 > 2 || @reported_4 > 2 || @reported_5 > 2 || @reported_6 > 2 
			@mocker.update(reported: true)
		end

		unless @reported_0 > 10 || @reported_1 > 2 || @reported_2 > 5 || @reported_3 > 2 || @reported_4 > 2 || @reported_5 > 20 || @reported_6 > 10
			if @appealed_reason_0 > 10
				@mocker.update(reported: false)
			end
			if @appealed_reason_1 > 10
				@mocker.update(reported: false)
			end
			if @appealed_reason_2 > 10
				@mocker.update(reported: false)
			end
			if @appealed_reason_3 > 50
				@mocker.update(reported: false)
			end
		end

	end

	def create
	end

	def update
		@mocker.update(new_params)

		if @mocker.update(mocker_params)
			redirect_to @mocker, notice: "Mocker was successfully updated!"
		else
			# render 'edit'
			flash[:alert] = "Uhm... Algo fallo."
		end

		#  new_params = mocker_params
		#  new_params = mocker_params.merge(active: true)
		
		#  if @mocker.update(new_params)
		#    flash[:notice] = "Genial! Esta guardado..."
		#  else
		#    flash[:alert] = "Uhm... Algo fallo."
		#  end
		#  redirect_to mock_path(@mock)
		#  redirect_back(fallback_location: request.referer)

	end


	def update_phone_number
		current_mocker.update_attributes(mocker_params)
		current_mocker.generate_pin
		current_mocker.send_pin

		redirect_to edit_mocker_registration_path, notice: "Great. It's saved"
		rescue Exception => e
		redirect_to edit_mocker_registration_path, alert: "#{e.message}"
	end



	def verify_phone_number
		current_mocker.verify_pin(params[:mocker][:pin])

		if current_mocker.phone_verified
		  flash[:notice] = "Your phone number has been verified."
		else
		  flash[:alert] = "Something goes wrong."
		end

		redirect_to edit_mocker_registration_path

		rescue Exception => e
		redirect_to edit_mocker_registration_path, alert: "#{e.message}"
	end


	def username_validator
	    if params[:slug].size <= 2
	    	render json: { valid: false }
	    elsif Mocker.find_by_slug(params[:slug].downcase) || Mocker.find_by_slug(params[:slug].upcase)
	    	render json: { valid: false }
	    elsif params[:slug].match(/\s/) || !params[:slug].match(/\A[a-zA-Z0-9]+\Z/)
	    	render json: { valid: false }
	    elsif !params[:slug].match(params[:slug].downcase)
	    	render json: { valid: false }
	    elsif params[:slug] == 'google' || params[:slug] == 'amazon' || params[:slug] == 'youtube' || 
	    	  params[:slug] == 'facebook' || params[:slug] == 'twitter' || params[:slug] == 'apple' || 
	    	  params[:slug] == 'billgates' || params[:slug] == 'stevejobs' || params[:slug] == 'fifa'|| 
	    	  params[:slug] == 'jeffbezos' || params[:slug] == 'elonmusk' || params[:slug] == 'tesla' || 
	    	  params[:slug] == 'nikolatesla' || params[:slug] == 'mockering' || params[:slug] == 'mocker' ||
	    	  params[:slug] == 'mocking' || params[:slug] == 'corona' || params[:slug] == 'profile' || 
	    	  params[:slug] == 'login' || params[:slug] == 'logout' || params[:slug] == 'sign_in' ||
	    	  params[:slug] == 'michaeljackson' || params[:slug] == 'beats' || params[:slug] == 'messi'|| 
	    	  params[:slug] == 'auronplay' || params[:slug] == 'rubius' || params[:slug] == 'luisitocomunica' || 
	    	  params[:slug] == 'bahamon' || params[:slug] == 'cristiano' || params[:slug] == 'ronaldo' ||
	    	  params[:slug] == 'intel' || params[:slug] == 'amd' || params[:slug] == 'ryzen' || params[:slug] == 'gamer'
	    	render json: {valid:false}
	    else
	    	render json: { valid: true }
	    end
	end

	def mentions
	  respond_to do |format|
	    format.json { render :json => Mention.all(params[:q]) }
	  end
	end


	private

	def set_mocker
    	@mocker = Mocker.friendly.find(params[:id])
	end

	def mocker_params
		params.require(:mocker).permit(:first_name, :last_name, :email, :birthday, :password, :password_confirmation, :slug, 
                    :bio, :photo, :tag_list, :coverpage, :facebook, :twitter, :instagram, :pinterest, :youtube,
                    :phone_number, :privated, :show_mocks_privated)
	end
end

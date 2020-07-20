class MockersController < ApplicationController
	before_action :authenticate_mocker!, except: [:show, :username_validator]
   	before_action :set_mocker, only: [:show, :edit, :update, :destroy]

	def show
    	@mocker = Mocker.friendly.find(params[:id])
    	@mocks = @mocker.mocks.order("created_at DESC").paginate(page: params[:page], per_page: 10)
	end

	def index
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


	private

	def set_mocker
    	@mocker = Mocker.friendly.find(params[:id])
	end

	def mocker_params
		params.require(:mocker).permit(:first_name, :last_name, :slug, :bio, :birthday, :photo, :coverpage, 
									   :facebook, :twitter, :pinterest, :instagram, :youtube)
	end
end

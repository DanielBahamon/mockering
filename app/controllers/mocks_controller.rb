class MocksController < ApplicationController
	before_action :is_authorised, only: [:edit]
	before_action :find_mock, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :like, :dislike]
	# before_action :is_admin!, except: [:index, :like, :dislike, :show, :upvote, :downvote, :destroy, :create, :edit, :new, :update]
	before_action :authenticate_mocker!, only: [:like, :dislike, :upvote, :downvote, :liked, :mocks]
	before_action :set_search

	impressionist :actions => [:show]
	autocomplete :tag, :name, :full => true

	def index
	  if mocker_signed_in?
	    @mock = current_mocker.mocks.build
	  end

	  @recents = Mock.where(privated: false, unlist: false)
	                 .where("mocks.created_at >= ?", 2.weeks.ago)
	                 .order(created_at: :desc)
	                 .limit(10)

	  @mocks = Mock.joins(:impressions)
	                 .group(:id)
	                 .order("RANDOM()")
	                 .where.not(id: @recents.pluck(:id))
	                 .where(mocktype: [0..9], privated: false, reported: false, unlist: false)
	                 .paginate(page: params[:page], per_page: 10)

	  @minimockers = Mocker.order("RANDOM()").limit(3)

	  # Obteniendo todos los registros paginados y combinándolos en @allmocks
	  @allmocks = (@recents + @mocks.to_a).sort_by(&:created_at).reverse
	end

	def mockets
	    if mocker_signed_in?
			@mock = current_mocker.mocks.build
	    end
		@mocks = Mock.all.joins(:impressions).group(:id).order("RANDOM()").where(mocktype: [1,2], privated: false, reported: false, unlist: false).limit(10).paginate(page: params[:mocks], per_page: 10)
		@minimockers = Mocker.all.order("RANDOM()").limit(3)
	end

	def mockies
	    if mocker_signed_in?
			@mock = current_mocker.mocks.build
	    end
		@mocks = Mock.all.joins(:impressions).group(:id).order("RANDOM()").where(mocktype: 0, privated: false, reported: false, unlist: false).limit(10).paginate(page: params[:mocks], per_page: 10)
		@minimockers = Mocker.all.order("RANDOM()").limit(3)
	end

	def tracks
	  if mocker_signed_in?
	    @mock = current_mocker.mocks.build
	  end

	  @mocks = Mock.where(mocktype: 3, privated: false, reported: false, unlist: false)
	               .where("music_file_name IS NOT NULL") # Asegura que haya un archivo adjunto de música
	               .where("movie_file_name IS NULL")     # Asegura que no haya un archivo adjunto de película
	               .limit(10)
	               .paginate(page: params[:mocks], per_page: 10)

	  @minimockers = Mocker.all.order("RANDOM()").limit(3)

	  #   if mocker_signed_in?
		# 	@mock = current_mocker.mocks.build
	  #   end
		# @mocks = Mock.all.joins(:impressions).group(:id).order("RANDOM()").where(mocktype: 3, privated: false, reported: false, unlist: false).limit(10).paginate(page: params[:mocks], per_page: 10)
		# @minimockers = Mocker.all.order("RANDOM()").limit(3)
	end

	def library
		@mocker = current_mocker
    	@mocks = @mocker.mocks.order("created_at DESC").paginate(page: params[:mocks], per_page: 10)
	end

	def discover
    	@mocks = Mock.all
    				.joins(:impressions)
    				.where(mocktype: [0..9], privated: false, reported: false, unlist: false)
    				.where("impressions.created_at <= '#{Time.now}' and mocks.created_at >= '#{12.month.ago}'")
					.group(:id)
					.order('mocks.created_at ASC')
    				.paginate(page: params[:mocks], per_page: 10)
		@minimockers = Mocker.all.order("RANDOM()").limit(3)

	end

	def loved
		@mocker = current_mocker
    	@mocks = @mocker.get_up_voted Mock.paginate(page: params[:mocks_page], per_page: 10)
	end


	def new
		@mock = current_mocker.mocks.build
	end

	def create
	  @mocker = current_mocker
	  @mock = current_mocker.mocks.build(mock_params)

	  @mock.mocktype = determine_mocktype(@mock)

	  if @mock.save
	    # notify_followers(@mocker, @mock)
	    redirect_to @mock, notice: "Successfully created new Mock"
	  else
	    render 'new'
	  end
	end

	def show
		@mock = Mock.find(params[:id])
		respond_to do |format|
			format.html { @mock }
			format.js
		end

		## impressionist(@mock, "message...") # 2nd argument is optional
		## Display all the host reviews to host (if this user is a guest)

		@reviews = @mock.reviews.paginate(page: params[:reviews_page], per_page: 2)
		@mocks_tags = ActsAsTaggableOn::Tag.most_used(10)
		if mocker_signed_in? && current_mocker.present?
			@related_mocks = current_mocker.mocks
	                            .where.not(id: @mock.id) # Excluir el mock actual
	                            .where(category: @mock.category, privated: false, reported: false, unlist: false)
	                            .limit(4)
		end

		@reported = MockReport.where(mock_id: @mock.id).count
		@reported_0 = MockReport.where(mock_id: @mock.id, classification: 0).count
		@reported_1 = MockReport.where(mock_id: @mock.id, classification: 1).count
		@reported_2 = MockReport.where(mock_id: @mock.id, classification: 2).count
		@reported_3 = MockReport.where(mock_id: @mock.id, classification: 3).count
		@reported_4 = MockReport.where(mock_id: @mock.id, classification: 4).count
		@reported_5 = MockReport.where(mock_id: @mock.id, classification: 5).count
		@reported_6 = MockReport.where(mock_id: @mock.id, classification: 6).count
		@appealed_reason_0 = MockAppeal.where(mock_id: @mock.id, reason: 0).count
		@appealed_reason_1 = MockAppeal.where(mock_id: @mock.id, reason: 1).count
		@appealed_reason_2 = MockAppeal.where(mock_id: @mock.id, reason: 2).count
		@appealed_reason_3 = MockAppeal.where(mock_id: @mock.id, reason: 3).count

		if @reported > 10
			@mock.update(reported: true)
		elsif @reported_0 > 5 || @reported_1 > 2 || @reported_2 > 2 || @reported_3 > 2 || @reported_4 > 2 || @reported_5 > 2 || @reported_6 > 2 
			@mock.update(reported: true)
		end

		unless @reported_0 > 10 || @reported_1 > 2 || @reported_2 > 5 || @reported_3 > 2 || @reported_4 > 2 || @reported_5 > 20 || @reported_6 > 10
			if @appealed_reason_0 > 10
				@mock.update(reported: false)
			end
			if @appealed_reason_1 > 10
				@mock.update(reported: false)
			end
			if @appealed_reason_2 > 10
				@mock.update(reported: false)
			end
			if @appealed_reason_3 > 50
				@mock.update(reported: false)
			end
		end
	end

	def like
		if current_mocker.voted_for? @mock
			@mock.unliked_by current_mocker
		else
			@mock.liked_by current_mocker
		end
	end

	def dislike
		if current_mocker.voted_for? @mock
			@mock.unliked_by current_mocker
		else
			@mock.downvote_from current_mocker
		end
	end

	def tagged
		if params[:tag].present?
			@mocks = Mock.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 10)
		else
			@mocks = Mock.all.paginate(:page => params[:page], :per_page => 10)
		end
	end

	def tag_cloud
		@tags = Mock.tag_counts_on(:tags)
	end

	def upvote
		@mock.upvote_from current_mocker
		redirect_back fallback_location: root_path
	end

	def downvote
		@mock.downvote_from current_mocker
		redirect_back fallback_location: root_path
	end

	def edit
	end
	
	def update
		if @mock.update(mock_params)
			redirect_to @mock, notice: "Mock was successfully updated!"
		else
			render 'edit'
		end
	end

	def destroy
		@mock.destroy
		redirect_to root_path
	end


	private

		def find_mock
			@mock = Mock.find(params[:id])
		end

		def find_review
			@review = Review.find(params[:id])
		end

		def mock_params
			params.require(:mock).permit(:title, :description, :picture, :music, :movie, :category, :credits, :tag_list, :privated, :age_restricted, :unlist, :duration, :mocktype, :type)
		end

		def determine_mocktype(mock)
		  if mock.movie.present?
    		mock.mocktype = 0
		  elsif mock.music.present?
    		mock.mocktype = 3
		  elsif mock.picture.present? && mock.description.present?
    		mock.mocktype = 1
		  elsif mock.picture.present? || mock.description.present?
		    :mockets
		  end
		end

		def set_search
			@q = Mock.ransack(params[:q])
			@mocks = @q.result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 30)
		end

		def is_authorised
			@mock = Mock.find(params[:id])
		  unless @mock.mocker_id == current_mocker.id
		    redirect_to root_path, alert: "You don't have permission to edit this mock."
		  end
		end
	
end

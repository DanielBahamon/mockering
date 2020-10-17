class MocksController < ApplicationController
	
	before_action :find_mock, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :like, :dislike]
	# before_action :is_admin!, except: [:index, :like, :dislike, :show, :upvote, :downvote, :destroy, :create, :edit, :new, :update]
	before_action :authenticate_mocker!, only: [:like, :dislike, :upvote, :downvote]
	before_action :set_search
  	impressionist :actions => [:show]
  	
  	autocomplete :tag, :name, :full => true

	def index
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
		if params[:tag].present?
			@mocks = Mock.tagged_with(params[:tag])
			.paginate(page: params[:page], per_page: 20)
			.where(privated: false)
		else
			@mocks = Mock.all.order("RANDOM()").paginate(page: params[:page], per_page: 9).where(privated: false, reported: false)
		end
		@mocks_whatever = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 0).limit(8)
		@mocks_knowledge = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 1).limit(8)
		@mocks_short = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 2).limit(8)
		@mocks_event = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 3).limit(8)

		@mocks_animation = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 4).limit(8)
		@mocks_videoclip = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 5).limit(8)
		@mocks_podcast = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 6).limit(8)
		@mocks_reaction = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 7).limit(8)
		@mocks_protest = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 8).limit(8)
		@mocks_health = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 9).limit(8)
		@mocks_history = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 10).limit(8)
		@mocks_tutorial = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 11).limit(8)
		@mocks_training = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 12).limit(8)
		@mocks_tribute = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 13).limit(8)
		@mocks_report = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 14).limit(8)
		@mocks_music = Mock.all.order("RANDOM()").where(privated: false, reported: false, category: 15).limit(8)
	end

	def popular
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}' and mocks.created_at >= '#{6.month.ago}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false)
    	# @mocks = Mock.joins(:impressions).where("impressions.created_at <= '#{Time.now}' and mocks.created_at >= '#{1.week.ago}  '").group("impressions.impressionable_id").order(impressions_count: :desc).paginate(page: params[:page], per_page: 20)
		# @mocks = Mock.order(impressions_count: :desc).paginate(page: params[:page], per_page: 20)
		# @mocks = Mock.joins(:impressions).group("impressions.impressionable_id").order("count(impression‌​s.id) DESC").paginate(page: params[:page], per_page: 30)
	end

	def latest
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.all.where("mocks.created_at >= '#{6.month.ago}'")
    	.order("created_at DESC")
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false)
		# @mocks = Mock.all.order('created_at DESC').paginate(page: params[:page], per_page: 20)
		# @mocks = Mock.joins(:impressions).group("impressions.impressionable_id").order("count(impression‌​s.id) DESC").paginate(page: params[:page], per_page: 30)
	end

	def new
		@mock = current_mocker.mocks.build
	end

	def create
		params[:mock][:tag_list] = params[:mock][:tag_list].join(',')
		@mocker = current_mocker
		@mock = current_mocker.mocks.build(mock_params)
		if @mock.save
			# create notification
			@mocker.followers.each do |mocker|
				Notification.create(recipient: mocker, actor: current_mocker, action: "mocked", notifiable: @mock)
			end
			redirect_to @mock, notice: "Successfully created new Mock"
		else
			render 'new'
		end
	end

	def show
	   	# impressionist(@mock, "message...") # 2nd argument is optional
	    # Display all the host reviews to host (if this user is a guest)
	    @reviews = @mock.reviews.paginate(page: params[:reviews_page], per_page: 2)
		@mocks_tags = ActsAsTaggableOn::Tag.most_used(10)
		@related_mocks = @mock.find_related_tags.where(privated: false, reported: false)

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
		params.require(:mock).permit(:title, :description, :picture, :music, :movie, :category, :credits, :tag_list, :privated, :age_restricted)
	end

	def set_search
		@q = Mock.ransack(params[:q])
		@mocks = @q.result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 30)
	end
	
end

class MocksController < ApplicationController
	
	before_action :find_mock, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :like, :dislike]
	# before_action :is_admin!, except: [:index, :like, :dislike, :show, :upvote, :downvote, :destroy, :create, :edit, :new, :update]
	before_action :authenticate_mocker!, only: [:like, :dislike, :upvote, :downvote, :liked, :mocks]
	before_action :set_search
  	impressionist :actions => [:show]
  	
  	autocomplete :tag, :name, :full => true

	def index
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
		if params[:tag].present?
			@mocks = Mock.tagged_with(params[:tag])
			.paginate(page: params[:page], per_page: 4)
			.where(privated: false)
		else
			@mocks = Mock.all.order("RANDOM()").paginate(page: params[:page], per_page: 4).where(privated: false, reported: false)
		end
		@new_mocks = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false).limit(8).where("mocks.created_at >= '#{1.week.ago}'")
		@mocks_whatever = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 0).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_knowledge = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 1).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_paranormal = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 2).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_short = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 3).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_aliens = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 4).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_animation = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 5).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_videoclip = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 6).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_podcast = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 7).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_reaction = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 8).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_protest = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 9).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_health = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 10).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_history = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 11).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_tutorial = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 12).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_training = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 13).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_tribute = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 14).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_report = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 15).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_music = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 16).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
		@mocks_nature = Mock.all.order("created_at DESC").where(privated: false, reported: false, unlist: false, category: 17).limit(8).where("mocks.created_at >= '#{4.month.ago}'")
	end



	def trends
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}' and mocks.created_at >= '#{1.month.ago}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false)
    	# @mocks = Mock.joins(:impressions).where("impressions.created_at <= '#{Time.now}' and mocks.created_at >= '#{1.week.ago}  '").group("impressions.impressionable_id").order(impressions_count: :desc).paginate(page: params[:page], per_page: 20)
		# @mocks = Mock.order(impressions_count: :desc).paginate(page: params[:page], per_page: 20)
		# @mocks = Mock.joins(:impressions).group("impressions.impressionable_id").order("count(impression‌​s.id) DESC").paginate(page: params[:page], per_page: 30)
	end

	def latest
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.all.where("mocks.created_at >= '#{1.month.ago}'")
    	.order("created_at DESC")
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false)
		# @mocks = Mock.all.order('created_at DESC').paginate(page: params[:page], per_page: 20)
		# @mocks = Mock.joins(:impressions).group("impressions.impressionable_id").order("count(impression‌​s.id) DESC").paginate(page: params[:page], per_page: 30)
	end


	def random
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.all.order("RANDOM()").where(privated: false, reported: false, unlist: false)
    	.paginate(page: params[:page], per_page: 20)
		# @mocks = Mock.all.order('created_at DESC').paginate(page: params[:page], per_page: 20)
		# @mocks = Mock.joins(:impressions).group("impressions.impressionable_id").order("count(impression‌​s.id) DESC").paginate(page: params[:page], per_page: 30)
	end

	def your_mocks
		@mocker = current_mocker
    	@mocks = @mocker.mocks.order("created_at DESC").paginate(page: params[:mocks], per_page: 10)
	end

	def liked
		@mocker = current_mocker
    	@mocks_liked = @mocker.get_up_voted Mock
    	# @mocks_liked = @mocker.votes.up.for_type(Mock)
    	@mocks = @mocks_liked.paginate(page: params[:mocks_page], per_page: 10)

	end

	def new
		@mock = current_mocker.mocks.build
	end

	def create
		params[:mock][:tag_list] = params[:mock][:tag_list].join(',')
		@mocker = current_mocker
		@mock = current_mocker.mocks.build(mock_params)
		
		# file = @mock.movie.queued_for_write[:original].path
		# @mock.duration = file[1].to_i * 3600 + file[2].to_i * 60 + file[3].to_i

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
		@related_mocks = @mock.find_related_tags.where(privated: false, reported: false, unlist: false)

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

	def whatever
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 0)
	end
	def knowledge
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 1)
	end
	def paranormal
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 2)
	end
	def shorts
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 3)
	end
	def aliens
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 4)
	end
	def animation
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 5)
	end
	def videoclips
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 6)
	end
	def podcasts
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 7)
	end
	def reactions
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 8)
	end
	def protests
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 9)
	end
	def health
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 10)
	end
	def history
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 11)
	end
	def tutorials
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 12)
	end
	def training
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 13)
	end
	def tributes
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 14)
	end
	def reports
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 15)
	end
	def music
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 16)
	end
	def nature
    	@tags = ActsAsTaggableOn::Tag.all.order('name ASC')
    	@mocks = Mock.joins(:impressions)
    	.where("impressions.created_at <= '#{Time.now}'")
    	.group(:id).order(impressions_count: :desc)
    	.paginate(page: params[:page], per_page: 20)
    	.where(privated: false, reported: false, unlist: false, category: 17)
	end

	private

		def find_mock
			@mock = Mock.find(params[:id])
		end

		def find_review
			@review = Review.find(params[:id])
		end

		def mock_params
			params.require(:mock).permit(:title, :description, :picture, :music, :movie, :category, :credits, :tag_list, :privated, :age_restricted, :unlist, :duration)
		end

		def set_search
			@q = Mock.ransack(params[:q])
			@mocks = @q.result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 30)
		end
	
end

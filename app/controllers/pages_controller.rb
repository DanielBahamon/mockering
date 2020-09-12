class PagesController < ApplicationController
	before_action :set_search

  	def terms
  	end


	def search
		@tags = ActsAsTaggableOn::Tag.all.order('name ASC')

	    @q = Mock.ransack(params[:q])
    	@mocks = @q.result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 30).where(privated: false, reported: false)
		# @mocks = @q.result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 20)
	end

	def policy
	end


	private

	def set_search
		@q = Mock.ransack(params[:q])
		@mocks = @q.result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 30).where(privated: false)
	end

end

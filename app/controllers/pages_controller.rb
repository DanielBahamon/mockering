class PagesController < ApplicationController

  	def terms
  	end


	def search
		@tags = ActsAsTaggableOn::Tag.all.order('name ASC')

	    @q = Mock.ransack(params[:q])
    	@mocks = @q.result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 30).where(privated: false, reported: false)
		# @mocks = @q.result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 20)

		if params[:tag].present?
			@mocks = Mock.tagged_with(params[:tag])
			.paginate(page: params[:page], per_page: 4)
			.where(privated: false, reported: false, unlist: false)
		else
			@mocks = @q.result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 30).where(privated: false, reported: false)
		end
	end

	def policy
	end


	private

end

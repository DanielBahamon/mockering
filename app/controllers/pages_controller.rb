class PagesController < ApplicationController

	def search
		@tags = ActsAsTaggableOn::Tag.all.order('name ASC')

		q = params[:q]
    	@mocks = Mock.ransack(mocker_slug_or_title_or_description_or_credits_cont: q).result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 20).where(privated: false, reported: false)
		@mockers = Mocker.ransack(first_name_or_last_name_or_slug_cont: q).result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 20).where(privated: false, reported: false)

		if params[:tag].present?
			@mocks = Mock.tagged_with(params[:tag])
			.paginate(page: params[:page], per_page: 4)
			.where(privated: false, reported: false, unlist: false)
		else
			@mocks = Mock.ransack(mocker_slug_or_title_or_description_or_credits_cont: q).result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 20).where(privated: false, reported: false)
			@mockers = Mocker.ransack(first_name_or_last_name_or_slug_cont: q).result(distinct: true).order("created_at DESC").paginate(page: params[:page], per_page: 20).where(privated: false, reported: false)
		end
	end

  	def terms
  	end

	def policy
	end

end

class ReviewsController < ApplicationController

  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_mock, only: [:show]

  def show
    @review = Review.find(params[:id])
  end

  def edit
     @mock = Mock.find(params[:id])
     @review = Review.find(params[:id])
  end

  def new
    @mock = Mock.find(params[:mock_id])
    @review = @mock.reviews.new
  end

  def create
    @review = Review.new(review_params)
    @review.mocker_id = current_mocker.id
    # @review = @mock.reviews.build(review_params)

    if @review.save
      flash[:notice] = 'Review was successfully created.'
      redirect_back(fallback_location: request.referer)
    else
      flash[:notice] = "Error creating review: #{@review.errors}"
      redirect_back(fallback_location: request.referer)
    end

  end

  def update
    @mock = Mock.find(params[:mock_id])
    @review = Review.find(params[:id])

    if @review.update_attributes(params[:review])
      flash[:notice] = "Review updated"
      redirect_back(fallback_location: request.referer)
    else
      flash[:error] = "There was an error updating your review"
      redirect_back(fallback_location: request.referer)
    end
  end

  def destroy
    @host_review = Review.find(params[:id])
    @host_review.destroy
    redirect_back(fallback_location: request.referer, notice: "Comentario eliminado!")
  end


  private

    def set_review
      @review = Review.find(params[:id])
    end

    def set_mock
      @mock = Mock.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:comment, :mocker_id, :mock_id)
    end

end

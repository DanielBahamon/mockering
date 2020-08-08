class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy, :like, :dislike, :upvote, :downvote]
  before_action :set_mock, only: [:show]
  before_action :set_review, only: [:show]

  def show
    @answer = Answer.find(params[:id])
    # Display all the host answers to host (if this user is a guest)
    @review = Review.find(params[:id])
    @mock = Mock.find(params[:id])
    @answers = review.answers.order(created_at: :desc).paginate(page: params[:page], per_page: 2)
  end

  def edit
     @mock = Mock.find(params[:id])
     @review = Review.find(params[:id])
     @answer = Answer.find(params[:id])
  end

  def new
    @mock = Mock.find(params[:mock_id])
    @review = Review.find(params[:review_id])
    @answer = @review.answers.new
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.mocker_id = current_mocker.id
    # @answer = @mock.answers.build(answer_params)

    if @answer.save
      flash[:notice] = 'Answer was successfully created.'
      redirect_back(fallback_location: request.referer)
    else
      flash[:notice] = "Error creating answer: #{@answer.errors}"
      redirect_back(fallback_location: request.referer)
    end
  end

  def update
    @mock = Mock.find(params[:review_id])
    @review = Review.find(params[:review_id])
    @answer = Answer.find(params[:id])

    if @answer.update_attributes(params[:answer])
      flash[:notice] = "Answer updated"
      redirect_back(fallback_location: request.referer)
    else
      flash[:error] = "There was an error updating your answer"
      redirect_back(fallback_location: request.referer)
    end
  end

  def destroy
    @host_answer = Answer.find(params[:id])
    @host_answer.destroy
    redirect_back(fallback_location: request.referer, notice: "Comentario eliminado!")
  end

  def like
    if current_mocker.voted_for? @answer
      @answer.unliked_by current_mocker
    else
      @answer.liked_by current_mocker
    end
  end

  def dislike
    if current_mocker.voted_for? @answer
      @answer.unliked_by current_mocker
    else
      @answer.downvote_from current_mocker
    end
  end


  private

    def set_answer
      @answer = Answer.find(params[:id])
    end

    def set_review
      @review = Review.find(params[:id])
    end

    def set_mock
      @mock = Mock.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:comment, :mocker_id, :mock_id, :review_id)
    end

end

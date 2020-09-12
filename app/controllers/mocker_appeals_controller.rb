class MockerAppealsController < ApplicationController
	before_action :authenticate_mocker!
  	before_action :set_appeal, only: [:show, :edit, :update, :destroy]
	skip_before_action :verify_authenticity_token

	def index
	end

	def new
		@appeal = current_mocker.mocker_appeals.build
	end

	def create
		# @appeal = MockReport.create(appeal_params)

		# @appeal = current_mocker.mock_reports.create(appeal_params)
		@appeal = current_mocker.mocker_appeals.build(appeal_params)
		if @appeal.save
			redirect_back fallback_location: root_path, notice: "Appealed. We'll check this case."
		else
			redirect_back fallback_location: root_path, alert: "Ops! Something goes wrong."
		end
	end


	private

    def set_appeal
      @appeal = MockerAppeal.find(params[:id])
    end

		def appeal_params
			params.require(:mocker_appeal).permit(:mocker_id, :reported_id, :comment, :reason)
		end
end

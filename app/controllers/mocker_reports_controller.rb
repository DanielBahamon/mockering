class MockerReportsController < ApplicationController
	before_action :authenticate_mocker!
  	before_action :set_report, only: [:show, :edit, :update, :destroy]
	skip_before_action :verify_authenticity_token

	def index
	end

	def new
		@report = current_mocker.mocker_reports.build
	end

	def create
		# @report = MockReport.create(report_params)

		# @report = current_mocker.mock_reports.create(report_params)
		@report = current_mocker.mocker_reports.build(report_params)
		if @report.save
			redirect_back fallback_location: root_path, notice: "Reported"
		else
			redirect_back fallback_location: root_path, alert: "Something goes wrong"
		end
	end


	private

    def set_report
      @report = MockerReport.find(params[:id])
    end

		def report_params
			params.require(:mocker_report).permit(:mocker_id, :reported_id, :classification, :comment)
		end
end

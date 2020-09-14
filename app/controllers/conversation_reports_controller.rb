class ConversationReportsController < ApplicationController
	before_action :authenticate_mocker!
		before_action :set_report, only: [:show, :edit, :update, :destroy]
	skip_before_action :verify_authenticity_token

	def index
	end

	def new
		@report = current_mocker.conversation_reports.build
	end

	def create
		@report = current_mocker.conversation_reports.build(report_params)
		if @report.save
			redirect_back fallback_location: root_path, notice: "Reported"
		else
			redirect_back fallback_location: root_path, alert: "Ops! Something goes wrong"
		end
	end


	private

	  def set_report
	    @report = ConversationReport.find(params[:id])
	  end

		def report_params
			params.require(:conversation_report).permit(:mocker_id, :conversation_id, :other_id, :classification, :comment)
		end

end

class BlocksController < ApplicationController
	before_action :authenticate_mocker!
		before_action :set_report, only: [:show, :edit, :update, :destroy]
	skip_before_action :verify_authenticity_token

	def index
	end

	def new
		@block = current_mocker.blocks.build
	end

	def create
		@block = current_mocker.blocks.build(report_params)
		if @block.save
			redirect_back fallback_location: root_path, notice: "Blocked"
		else
			redirect_back fallback_location: root_path, alert: "Ops! Something goes wrong"
		end
	end


	private

	  def set_report
	    @block = Block.find(params[:id])
	  end

		def report_params
			params.require(:block).permit(:mocker_id, :blocked_id, :reason, :status)
		end

end

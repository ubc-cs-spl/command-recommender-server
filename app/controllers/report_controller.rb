class ReportController < ApplicationController
  def get_reports
    unless @user_id = User.where(:user_id => params[:user_id])
      render json: {status => 422}
    end

    @reports = Report.where(:user_id => params[:user_id])

    render json: @reports.to_json(:include =>
                                      {:command_stats => {:include => :command_detail},
                                       :newly_learned_commands => {:include => :command_detail}})
  end
end

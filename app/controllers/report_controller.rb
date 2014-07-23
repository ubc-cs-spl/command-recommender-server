class ReportController < ApplicationController
  def get_reports
    unless @user_id = User.where(:user_id => params[:user_id])
      render json: {status => 422}
    end

    @reports = Report.where(:user_id => params[:user_id])
   
    render json: @reports.to_json
  end
end

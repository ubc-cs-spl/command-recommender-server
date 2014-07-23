class ReportController < ApplicationController
  def get_reports
    unless @user_id = User.where(:user_id => params[:user_id])
      render json: {status => 422}
    end

    @report = Report.where(:user_id => params[:user_id])
    @report.each{ |report_item|
      report_item.command_stats.each{ |command_stat|
        puts command_stat["command_id"]
        puts CommandDetail.where(:command_id => command_stat["command_id"]).first()
        command_stat["command_detail"] = CommandDetail.where(:command_id => command_stat["command_id"]).first().to_json
      }
    }
    render json: @report.to_json
  end
end

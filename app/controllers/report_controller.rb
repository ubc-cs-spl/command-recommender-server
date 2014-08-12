require 'mongo'

class ReportController < ApplicationController
  include Mongo

  def get_report
    render json: Report.retrieve_report(params[:user_id], params[:num_days])
  end

end

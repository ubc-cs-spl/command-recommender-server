class CommandDetailsController < ApplicationController
  respond_to :json
  def update
    unless @command_detail = CommandDetail.find(params[:command_detail_id])
      render :json => {status: 422}
    end
    puts @command_detail
    @command_detail.command_name = params[:command_name]
    @command_detail.description = params[:description]
    @command_detail.shortcut = params[:shortcut]
    puts @command_detail.to_json
    puts params[:command_detail]
    if @command_detail.save
      render :json => @command_detail
    else
      render :json => {:errors => @command_detail.errors}, :status => 422
    end
  end

  def show
      if @command_detail = CommandDetail.find(params[:command_detail_id])
       render json: @command_detail
      else
       render :json, :status => 500
      end
  end

  def find
    if params[:filter] == 'all'
      @command_details = CommandDetail.where(params[:filter_type] => /#{params[:filter_value]}.*/).fields(:command_id, :command_name).all
    else
      @command_details = CommandDetail.where(params[:filter_type] => /#{params[:filter_value]}.*/, :command_name => "").fields(:command_id, :command_name).all
    end

    render :json => @command_details.to_json
  end
end
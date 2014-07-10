class CommandDetailsController < ApplicationController
  respond_to :json
  def update
    @command_detail = CommandDetail.find(params[:command_detail_id])
    @command_detail.command_name = params[:command_name]
    @command_detail.description = params[:description]
    @command_detail.shortcut = params[:shortcut]

    respond_to do |format|
        if @command_detail.save
          format.json {render :json => @command_detail}
        else
          format.json {render :json => {status: 422, errors: @command_detail.errors}}
        end
      end
  end

  def show
    respond_to do |format|
      if @command_detail = CommandDetail.find(params[:command_detail_id])
        format.json { render :json => @command_detail}
      else
        format.json { render :json => {status: 500}}
      end
    end
  end

  def find
    
  end
end

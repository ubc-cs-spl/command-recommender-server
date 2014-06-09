require 'rubygems'
require 'json'

class CommandRecommenderController < ApplicationController
	respond_to :json

	def upload_data
		saved = save_data(params[:user_id],params[:commands])
    if saved
      unless @user = User.find(params[:user_id])
        @user = User.new({:user_id => params[:user_id], :last_upload_date => Time.now.getutc})
      else
        @user.last_upload_date = Time.now.getutc
      end
    end
		respond_to do |format|
			if saved && @user.save
				format.json {render :json => params[:commands]}
			else
				format.json {render json: "Something wrong", status: 422}
			end	
		end
	end

	private
	def save_data(user_id, usage_data)
			saved = true
			usage_data.each{ |command|	
				new_command = Command.new(:user_id => user_id,
										:what => command[:what],
										:kind => command[:kind],
										:bundleVersion => command[:bundleVersion],
										:description => command[:description],
										:bindingUsed => command[:bindingUsed],
										:time => command[:time])
						
				if not new_command.save
					saved = false
				end
										
			}
			return saved		
	end
end


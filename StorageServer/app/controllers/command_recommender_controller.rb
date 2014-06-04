require 'rubygems'
require 'json'

class CommandRecommenderController < ApplicationController
	respond_to :json

	def upload_data
		saved = save_data(params[:user_id],params[:commands])
		respond_to do |format|
			if saved
				format.json {render :json => params[:commands]}
			else
				format.json {render json: "Somethign wrong", status: 422}
			end	
		end
	end

	def create_recommendations	
		recommendation = get_recommendation(params[:user_id])
		render text: "http://localhost:3000/recommendation/#{params[:user_id]}"
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
				logger.debug new_command.inspect
						
				if not new_command.save
					saved = false
				end
										
			}
			return saved		
	end


	def get_recommendation(user_id)
		jar_location = Rails.root.join('lib')
		
		command = "java -jar #{Rails.root}/lib/recommender.jar 5 " + user_id
		puts command
		recommend = IO.popen(command)	
				
		return recommend.gets
	end
end


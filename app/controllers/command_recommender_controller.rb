require 'rubygems'
require 'json'

class CommandRecommenderController < ApplicationController
	respond_to :json

	def upload_data
		File.open('/home/spencer/test_file.json', 'w'){|f| 
			f.write(params.inspect)
		}
		save_data(params[:user_id],params[:commands])
		render text: params[:usage_data]		
	end

	def get_recommendations
		recommendation = Recommendation.new(:user_id)
		render text: recommendation.create_recommendation()
	end

	private
	def save_data(user_id, usage_data)
			usage_data.each{ |command|
			new_command = Command.new(:user_id => user_id,
										:what => command[:what],
										:kind => command[:kind],
										:bundlVersion => command[:bundleVersion],
										:description => command[:description],
										:bindingUsed => command[:bindingUsed],
										:time => command[:time])
			new_command.save!
										
		}		
	end
end

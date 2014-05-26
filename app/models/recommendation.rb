class Recommendation

	def initialize(user_id)
		@user_id = user_id
	end
	
	def create_recommendation()
	  recommendations = get_recommendation(@user_id)
	  return recommendations
	end

private
	def get_recommendation(user_id)
		recommend = IO.popen("java -jar ~/ruby_test/dummy.jar 5")	
		#recommend = IO.popen("date")	
		return recommend.gets
	end
  		  
end

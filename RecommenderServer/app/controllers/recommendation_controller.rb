class RecommendationController < ApplicationController
  def get_recommendations
      @recommendations = Recommendation.where(:user_id => params[:user_id])
       puts @recommendations.count
      render json: @recommendations.to_json(:include => :command_detail)
  end

  def mark_recommendaiton
    @recommendation = Recommendation.find(params[:recommendation_id])
    @recommendation.useful = params[:useful]
    @recommendation.save
    render json: @recommendation.to_json
  end
end

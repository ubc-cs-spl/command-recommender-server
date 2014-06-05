class RecommendationController < ApplicationController
  def get_recommendations
      @recommendations = Recommendation.where(:user_id => params[:user_id])
      render json: @recommendations.to_json(:include => :command_detail)
  end

  def mark_recommendaiton
    @recommendation = Recommendation.find(params[:recommendation_id])
    @recommendation.useful = false
    @recommendation.save
    render json: @recommendation.to_json
  end
end

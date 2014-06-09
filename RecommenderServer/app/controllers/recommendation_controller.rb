class RecommendationController < ApplicationController
  def get_recommendations
    if params[:current] == 'current'
      @recommendations = Recommendation.where(:user_id => params[:user_id]).sort(:new.desc).limit(10)
    else
      @recommendations = Recommendation.where(:user_id => params[:user_id]).sort(:new.desc).skip(10)
    end
    render json: @recommendations.to_json(:include => :command_detail)
  end

  def mark_recommendaiton
    @recommendation = Recommendation.find(params[:recommendation_id])
    @recommendation.useful = params[:useful]
    @recommendation.save
    render json: @recommendation.to_json
  end
end

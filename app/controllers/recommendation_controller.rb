class RecommendationController < ApplicationController
  def get_recommendations

    if params[:current] == 'current'
      @recommendations = Recommendation.where(:user_id => params[:user_id]).sort(:new_recommendation.desc).limit(10)
    else
      @recommendations = Recommendation.where(:user_id => params[:user_id]).sort(:new_recommendation.desc).skip(10)
    end
    unless @user = User.find_by_user_id(params[:user_id])
      puts @user.inspect
      render json: {status: 400}
    else
      puts @user.inspect
      render json: @recommendations.to_json(:include => :command_detail)
    end
  end

  def mark_recommendaiton
    @recommendation = Recommendation.find(params[:recommendation_id])
    @recommendation.useful = params[:useful]
    @recommendation.save
    render json: @recommendation.to_json
  end
end

class RecommendationController < ApplicationController
  def get_recommendations
    if params[:current] == 'current'
      @recommendations = Recommendation.where(
                                              :user_id => params[:user_id],
                                              :algorithm_type => params[:algorithm_type],
                                              :saved => {:$ne => true},
                                              :useful => {:$ne => false}
                                             )
                                        .sort(:rank.asc).limit(10)
    elsif params[:current] == 'all'
      @recommendations = Recommendation.where(:user_id => params[:user_id],
                                              :algorithm_type => params[:algorithm_type],
                                              :saved => {:$ne => true},
                                              :useful => {:$ne => false},
                                              :rank => {:$ne => nil},
                                              ).sort(:rank.asc).skip(10)
    else
      @recommendations = Recommendation.where(:user_id => params[:user_id], :saved => true)
    end

    render json: @recommendations.to_json(:include => :command_detail)
  end

  def mark_recommendation
    @recommendation = Recommendation.find(params[:recommendation_id])
    @recommendation.useful = params[:useful]
    @recommendation.save
    render json: @recommendation.to_json
  end

  def save_recommendation
    @recommendation = Recommendation.find(params[:recommendation_id])
    @recommendation.saved = params[:saved]
    @recommendation.save
    render json: @recommendation.to_json
  end

  def is_valid_user
    if User.find_by_user_id(params[:user_id])
      render json: {:valid => true}
    else
      render json: {:valid => false}
    end
  end

  def get_algorithm_types
    @algorithm_types = Recommendation.where(:user_id => params[:user_id]).distinct(:algorithm_type)
    render json: @algorithm_types
  end
end

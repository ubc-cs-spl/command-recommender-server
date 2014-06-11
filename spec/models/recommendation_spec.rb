require 'spec_helper'

describe Recommendation, :type => :model do
  before :all do
    @recommendation = FactoryGirl.build(:recommendation)
  end

  after :all do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  describe "Creating a valid recommendation" do
    it {expect(@recommendation.valid?).to eq(true)}
    specify {
      expect(@recommendation.save).to eq(true)
      saved_recommendation = Recommendation.find(@recommendation.id)
      command_detail = CommandDetail.find(saved_recommendation.command_detail.id)
      expect(saved_recommendation).to eq(@recommendation)
      expect(saved_recommendation.command_detail).to eq(command_detail)
    }
  end

  describe "Creating an invalid recommendation" do
    context "with no user_id" do
      before{@recommendation.user_id = ""}
      it{expect(@recommendation.valid?).to eq(false)}
      it{expect(@recommendation.save).to eq(false)}
    end

    context "with no created_on" do
      before{@recommendation.created_on = ""}
      it{expect(@recommendation.valid?).to eq(false)}
      it{expect(@recommendation.save).to eq(false)}
    end

    context "with no reason" do
      before{@recommendation.reason = ""}
      it{expect(@recommendation.valid?).to eq(false)}
      it{expect(@recommendation.save).to eq(false)}
    end

    context "with no command detail" do
      before {
        @recommendation.command_detail_id = nil
        @recommendation.command_detail = nil
      }
      it{expect(@recommendation.valid?).to eq(false)}
      it{expect(@recommendation.save).to eq(false)}
    end
  end
end

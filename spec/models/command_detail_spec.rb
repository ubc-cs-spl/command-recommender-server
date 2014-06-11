require 'rails_helper'

RSpec.describe CommandDetail, :type => :model do
  before(:each) do
    @command_detail = FactoryGirl.build(:command_detail)
  end

  after(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  describe "valid command_detail should save and be valid" do
    it{expect(@command_detail.valid?).to eq(true)}
    it{expect(@command_detail.save).to eq(true)}
  end

  describe "invalid command detail should not be valid and save when" do
    context "no command_name is present" do
      before{@command_detail.command_name = ""}
      it{expect(@command_detail.valid?).to eq(false)}
      it{expect(@command_detail.save).to eq(false)}
    end

    context "no command_id is present" do
      before{@command_detail.command_id = ""}
      it{expect(@command_detail.valid?).to eq(false)}
      it{expect(@command_detail.save).to eq(false)}
    end

    context "no description is present" do
      before{@command_detail.description = ""}
      it{expect(@command_detail.valid?).to eq(false)}
      it{expect(@command_detail.save).to eq(false)}
    end

    context "a duplicate command_id is present" do
      before{
        @command_detail_create_first = FactoryGirl.create(:command_detail)
      }
      it{expect(@command_detail.valid?).to eq(false)}
      it{expect(@command_detail.save).to eq(false)}
    end
  end
end

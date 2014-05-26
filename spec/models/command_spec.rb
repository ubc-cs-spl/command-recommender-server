require 'spec_helper'

describe Command, :type => :model do
	before :each do
	   @command = Command.new(:user_id => "user_id",
						:what => "what",
						:kind => "kind",
						:bundVersion => "bundleVersion",
						:description => "description",
						:bindingUsed => true,
						:time => 1)
	end

	describe "The command" do
		it "should have the correct user id" do
			@command.user_id.should_be == "user_id"
		end
		
		it "should have the correct what" do
			@command.what.should_be == "what"
		end
	
		it "should have the correct kind" do
			@command.kind.should_be == "kind"
		end
		
		it "should have the correct bundleVersion" do
			@command.bundleVersion.should_be == "bundleVersion"
		end

		it "should have the correct description" do
			@command.description.should_be == "description"
		end

		it "should have the correct bindingUsed" do
			@command.bindingUsed.should_be true
		end
		
		it "should have the correct time" do
			@command.time.should_be 1
		end	
	end	
end

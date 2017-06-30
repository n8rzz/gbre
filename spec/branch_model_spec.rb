require "spec_helper"

RSpec.describe Gbre::BranchModel do
  it "should accept a name" do
    @branchModel = Gbre::BranchModel.new('feature/123')
    expect(@branchModel.name).to eq "feature/123"
  end

  it "sets #is_active_branch to false when no value is provided" do
    @branchModel = Gbre::BranchModel.new('feature/123')
    expect(@branchModel.is_active_branch).to eq false
  end

  it "does not set #api_url when #is_issue is false" do
    @branchModel = Gbre::BranchModel.new('develop')
    expect(@branchModel.api_url).to eq ''
  end

  it "does not set #api_url when a branch name does not include a number" do
    @branchModel = Gbre::BranchModel.new('release/0.0.0')
    expect(@branchModel.api_url).to eq ''
  end

  # it "builds the correct array when #issue_state is defined" do
  #   @branchModel = Gbre::BranchModel.new('release/0.0.0')
  #
  # end
end

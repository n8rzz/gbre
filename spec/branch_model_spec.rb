require "spec_helper"
require "json"

RSpec.describe Gbre::BranchModel do
  let(:feature_mock) { 'feature/123' }
  let(:develop_mock) { 'develop' }
  let(:release_mock) { 'release/1.2.3' }
  let(:named_branch_mock) { 'feature/threeve' }

  describe "a branch that maps to an issue" do
    before :each do
      issue_response = {'title' => 'An Issue Title', 'status' => 'open'}.to_json
      allow(Gbre::GithubIssueRepository).to receive(:get).and_return(issue_response)
    end

    it "should accept a name" do
      @branchModel = Gbre::BranchModel.new(feature_mock)
      expect(@branchModel.name).to eq feature_mock
    end

    it "sets #is_active_branch to false when no value is provided" do
      @branchModel = Gbre::BranchModel.new(feature_mock)
      expect(@branchModel.is_active_branch).to eq false
    end

    it "builds the correct array when #issue_state is defined" do
      @branchModel = Gbre::BranchModel.new(release_mock)
      expect(@branchModel.display_branch).to include("release/1.2.3", "")
    end
  end

  describe "a branch that does not map to an issue" do
    before :each do
      issue_response = {'title' => 'An Issue Title', 'status' => 'open'}.to_json
      allow(Gbre::GithubIssueRepository).to receive(:get).and_return(issue_response)
    end
  end
end

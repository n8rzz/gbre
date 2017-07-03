require 'spec_helper'
require 'json'

RSpec.describe Gbre::BranchModel do
  let(:feature_mock) { 'feature/123' }
  let(:develop_mock) { 'develop' }
  let(:release_mock) { 'release/1.2.3' }
  let(:named_branch_mock) { 'feature/threeve' }

  describe 'a branch that maps to an issue' do
    before :each do
      issue_response = { 'title' => 'An Issue Title',
                         'status' => 'open' }.to_json
      allow(Gbre::GithubIssueRepository).to receive(:get)
        .and_return(issue_response)
    end

    it 'should accept a name' do
      @branch_model = Gbre::BranchModel.new(feature_mock)
      expect(@branch_model.name).to eq feature_mock
    end

    it 'sets #is_active_branch to false when no value is provided' do
      @branch_model = Gbre::BranchModel.new(feature_mock)
      expect(@branch_model.is_active_branch).to eq false
    end

    it 'returns the correct string when the branch maps to an issue number' do
      @branch_model = Gbre::BranchModel.new(feature_mock)
      expect(@branch_model.display_branch).to include('open', 'feature/123', 'An Issue Title')
    end
  end

  describe 'a branch that does not map to an issue' do
    before :each do
      issue_response = { 'title' => 'An Issue Title',
                         'status' => 'open' }.to_json
      allow(Gbre::GithubIssueRepository).to receive(:get)
        .and_return(issue_response)
    end

    it 'does not set issue number for a main branch' do
      @branch_model = Gbre::BranchModel.new(develop_mock)
      expect(@branch_model.issue_number).to eq -1
    end

    it 'returns the correct string for a main branch' do
      @branch_model = Gbre::BranchModel.new(develop_mock)
      expect(@branch_model.display_branch).to include('develop')
    end

    it 'does not set issue number for a release branch' do
      @branch_model = Gbre::BranchModel.new(release_mock)
      expect(@branch_model.issue_number).to eq -1
    end

    it 'returns the correct string for a release branch' do
      @branch_model = Gbre::BranchModel.new(release_mock)
      expect(@branch_model.display_branch).to include('release/1.2.3')
    end
  end
end

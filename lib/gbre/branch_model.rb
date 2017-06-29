#!/bin/env/ruby

# require 'rainbow'
require 'json'

module Gbre
  class BranchModel
    attr_accessor :name
    attr_accessor :api_url
    attr_accessor :issue_number
    attr_accessor :issue_state
    attr_accessor :issue_title
    attr_accessor :is_active_branch
    attr_accessor :is_issue

    def initialize(name, is_active_branch = false)
      api_issue_url_partial = 'https://api.github.com/repos/openscope/openscope/issues'

      @name = name
      @api_url = ''
      @is_active_branch = is_active_branch
      @is_issue = name.include?('.') || name.include?('/')

      return if !@is_issue
      return if name.partition('/').last.to_i == 0

      @issue_number = name.partition('/').last.to_i
      @api_url = "#{api_issue_url_partial}/#{@issue_number}"

      get_current_issue_status
    end

    def display_branch
      colored_issue_state = @issue_state == 'open' ? Rainbow("(#{@issue_state})").green : Rainbow("(#{@issue_state})").red
      colored_active_branch = @is_active_branch ? Rainbow("#{@name}").magenta : "#{@name}"
      colored_issue_title = @is_active_branch ? Rainbow("#{@issue_title}").magenta : "#{@issue_title}"

      if @is_issue
        branch_view = [colored_issue_state.to_s, colored_active_branch.to_s, colored_issue_title.to_s]

        return branch_view
      end

      branch_view = ["", colored_active_branch.to_s, ""]
      branch_view
    end

    private

    def get_current_issue_status
      # issue_response = JSON.parse(HttpService.get(@api_url))

      # @issue_state = issue_response["state"]
      # @issue_title = issue_response["title"]
      @issue_state = 'open'
      @issue_title = 'a placeholder issue title'
    end
  end
end

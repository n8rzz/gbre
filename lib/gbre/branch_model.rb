require 'json'

module Gbre
  class BranchModel
    attr_accessor :name
    attr_accessor :issue_number
    attr_accessor :issue_state
    attr_accessor :issue_title
    attr_accessor :is_active_branch
    attr_accessor :is_issue

    def initialize(name, is_active_branch = false)
      @name = name
      @is_active_branch = is_active_branch
      @is_issue = name.include?('/')

      set_issue_number
    end

    def set_issue_number
      branch_name_after_slash = @name.partition('/').last

      should_check_status?(branch_name_after_slash)

      @issue_number = branch_name_after_slash.to_i

      read_current_issue_status
    end

    def display_branch
      colored_active_branch = build_magenta_text_with_condition(@name, @is_active_branch)
      colored_issue_title = build_magenta_text_with_condition(@issue_title, @is_active_branch)
      colored_issue_state = ''

      if @issue_state != ''
        colored_issue_state = build_colored_issue_state
      end

      if @is_issue
        branch_view = [
          colored_issue_state.to_s,
          colored_active_branch.to_s,
          colored_issue_title.to_s
        ]

        return branch_view
      end

      branch_view = ['', colored_active_branch.to_s, '']
      branch_view
    end

    private

    def should_check_status?(branch_name_after_slash)
      @is_issue || !branch_name_after_slash.to_i.zero? || !branch_name_after_slash.include?('.')
    end

    def read_current_issue_status
      api_url = build_api_url
      issue_response = JSON.parse(GithubIssueRepository.get(api_url))

      @issue_state = issue_response['state']
      @issue_title = issue_response['title']
    end

    def build_api_url
      "https://api.github.com/repos/openscope/openscope/issues/#{@issue_number}"
    end

    def build_magenta_text_with_condition(text, condition)
      if condition
        return Rainbow(text.to_s).magenta
      end

      Rainbow(text.to_s)
    end

    def build_colored_issue_state
      @issue_state == 'open' ? Rainbow(@issue_state.to_s).green : Rainbow(@issue_state.to_s).red
    end
  end
end

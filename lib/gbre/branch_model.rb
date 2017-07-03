require 'json'

module Gbre
  # A single, local git branch
  #
  # May or may not be associated with a specific Github issue
  #
  # Expected formats:
  # - `CATEGORY/ISSUE_NUMBER` - a hotfix, bugfix or feature branch
  # - `release/x.x.x`         - a release branch containing a semver version number
  # - `master`                - a main branch, unsually `develop` or `master`
  class BranchModel
    # @return [String] name of the local branch
    attr_accessor :name

    # @return [Numeric] an extrapolated issue number pulled from the branch name
    attr_accessor :issue_number

    # @return [Boolean] state of the issue on Github [open, closed]
    attr_accessor :issue_state

    # @return [String] Github issue title
    attr_accessor :issue_title

    # @return [Boolean] is the branch checked out locally
    attr_accessor :is_active_branch

    # @return [Booelan] is the branch an issue style branch
    attr_accessor :is_issue

    # @param name [String] name of the local git branch
    # @param is_active_branch [Boolean] is the branch checked out locally
    def initialize(name, is_active_branch = false)
      @name = name
      @is_active_branch = is_active_branch
      @is_issue = name.include?('/')

      set_issue_number
    end

    # Store issue status from Github api response
    def set_issue_number
      branch_name_after_slash = @name.partition('/').last

      should_check_status?(branch_name_after_slash)

      @issue_number = branch_name_after_slash.to_i

      read_current_issue_status
    end

    # Generate an array that can be used by `terminal-table` gem
    # @return [Array<String>]
    def display_branch
      colored_active_branch = build_magenta_text_with_condition(@name, @is_active_branch)
      colored_issue_title = build_magenta_text_with_condition(@issue_title, @is_active_branch)
      colored_issue_state = ''

      colored_issue_state = build_colored_issue_state if @issue_state != ''

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

    # @return [Boolean] can we check the status of this branch
    def should_check_status?(branch_name_after_slash)
      @is_issue || !branch_name_after_slash.to_i.zero? || !branch_name_after_slash.include?('.')
    end

    def read_current_issue_status
      api_url = build_api_url
      issue_response = JSON.parse(GithubIssueRepository.get(api_url))

      @issue_state = issue_response['state']
      @issue_title = issue_response['title']
    end

    # @return [String] Github api uri with issue number
    def build_api_url
      "https://api.github.com/repos/openscope/openscope/issues/#{@issue_number}"
    end

    # @param text [String] the text to display
    # @param condition [Boolean] evaluated boolean used to determine output color
    # @return [String] colorized string
    def build_magenta_text_with_condition(text, condition)
      return Rainbow(text.to_s).magenta if condition

      Rainbow(text.to_s)
    end

    def build_colored_issue_state
      @issue_state == 'open' ? Rainbow(@issue_state.to_s).green : Rainbow(@issue_state.to_s).red
    end
  end
end

# Gems
require 'rainbow'
require 'terminal-table'

require 'gbre/github_issue_repository'
require 'gbre/branch_model'
require 'gbre/branch_collection'
require 'gbre/version'

module Gbre
  class Command
    def self.execute
      branch_collection = BranchCollection.new
      branch_collection.display_branch_list
    end
  end
end

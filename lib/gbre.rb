#!/bin/env/ruby

# Gems
require "rainbow"
require "terminal-table"

require "gbre/http_service"
require "gbre/branch_model"
require "gbre/branch_collection"
require "gbre/version"

module Gbre
  class Command
    def self.execute
      branchCollection = BranchCollection.new
      branchCollection.display_branch_list
    end
  end
end

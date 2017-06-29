#!/bin/env/ruby

# require 'terminal-table'

module Gbre
  class BranchCollection
    attr_accessor :items

    def initialize
      @items = build_branch_list
    end

    def display_branch_list
      table = Terminal::Table.new do |t|
        t.title = "GIT Branch Enhanced"
        t.style.padding_left = 2
        t.style.padding_right = 2
        t.headings = ['State', 'Branch Name', 'Issue Title']

        @items.each do |b|
          t.add_row b.display_branch
        end

        t.align_column(0, :right)
      end

      puts table
    end

    private

    def build_branch_list
      local_branches = %x[git branch].split(' ')
      active_branch_index = local_branches.index('*')

      local_branches.select{ |i| i != '*'}.map.with_index{ |b, i| BranchModel.new(b, i == active_branch_index) }
    end
  end
end

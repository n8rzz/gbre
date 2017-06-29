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
      puts 'hello'
    end
  end
end



# require 'net/https'
# require "open-uri"

# class HttpService
#   def self.get(uri)
#     uri = URI.parse(uri)
#     http = Net::HTTP.new(uri.host, 443)
#     http.use_ssl = true
#
#     request = Net::HTTP::Get.new(uri.path)
#     request['User-Agent'] = 'n8rzz'
#     response = http.request(request)
#
#     response.body
#   end
# end
#
#
# # require 'rainbow'
# # require 'json'
#
# class BranchModel
#   attr_accessor :name
#   attr_accessor :api_url
#   attr_accessor :issue_number
#   attr_accessor :issue_state
#   attr_accessor :issue_title
#   attr_accessor :is_active_branch
#   attr_accessor :is_issue
#
#   def initialize(name, is_active_branch = false)
#     api_issue_url_partial = 'https://api.github.com/repos/openscope/openscope/issues'
#
#     @name = name
#     @api_url = ''
#     @is_active_branch = is_active_branch
#     @is_issue = name.include?('.') || name.include?('/')
#
#     return if !@is_issue
#     return if name.partition('/').last.to_i == 0
#
#     @issue_number = name.partition('/').last.to_i
#     @api_url = "#{api_issue_url_partial}/#{@issue_number}"
#
#     get_current_issue_status
#   end
#
#   def display_branch
#     colored_issue_state = @issue_state == 'open' ? Rainbow("(#{@issue_state})").green : Rainbow("(#{@issue_state})").red
#     colored_active_branch = @is_active_branch ? Rainbow("#{@name}").magenta : "#{@name}"
#     colored_issue_title = @is_active_branch ? Rainbow("#{@issue_title}").magenta : "#{@issue_title}"
#
#     if @is_issue
#       branch_view = [colored_issue_state.to_s, colored_active_branch.to_s, colored_issue_title.to_s]
#
#       return branch_view
#     end
#
#     branch_view = ["", colored_active_branch.to_s, ""]
#     branch_view
#   end
#
#   private
#
#   def get_current_issue_status
#     # issue_response = JSON.parse(HttpService.get(@api_url))
#
#     # @issue_state = issue_response["state"]
#     # @issue_title = issue_response["title"]
#     @issue_state = 'open'
#     @issue_title = 'a placeholder issue title'
#   end
# end
#
#
# # require 'terminal-table'
#
# class BranchCollection
#   attr_accessor :items
#
#   def initialize
#     @items = build_branch_list
#   end
#
#   def display_branch_list
#     table = Terminal::Table.new do |t|
#       t.title = "GIT Branch Enhanced"
#       t.style.padding_left = 2
#       t.style.padding_right = 2
#       t.headings = ['State', 'Branch Name', 'Issue Title']
#
#       @items.each do |b|
#         t.add_row b.display_branch
#       end
#
#       t.align_column(0, :right)
#     end
#
#
#     puts table
#   end
#
#   private
#
#   def build_branch_list
#     local_branches = %x[git branch].split(' ')
#     active_branch_index = local_branches.index('*')
#
#     local_branches.select{ |i| i != '*'}.map.with_index{ |b, i| BranchModel.new(b, i == active_branch_index) }
#   end
# end
#
#
# branchModelCollection = BranchCollection.new
# branchModelCollection.display_branch_list

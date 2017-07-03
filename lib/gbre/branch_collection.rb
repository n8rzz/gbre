module Gbre
  class BranchCollection
    def initialize
      @items = build_branch_list
    end

    def display_branch_list
      table = build_table_view

      puts "\n\n"
      puts table
    end

    private

    def build_table_view
      Terminal::Table.new do |t|
        t.title = 'GIT Branch Enhanced'
        t.style.padding_left = 2
        t.style.padding_right = 2
        t.headings = ['State', 'Branch Name', 'Issue Title']

        @items.each do |b|
          t.add_row b.display_branch
        end

        t.align_column(0, :right)
      end
    end

    def build_branch_list
      local_branches = `git branch`.split(' ')
      active_branch_index = local_branches.index('*')

      local_branches.reject { |i| i == '*' }.map.with_index do |b, i|
        BranchModel.new(b, i == active_branch_index)
      end
    end
  end
end

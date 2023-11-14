# frozen_string_literal: true

# Monkey patching column widths to take into account cell length not including terminal escapes
# Thank you to https://github.com/mikecarlton-illumio/text-table for solving this problem
module Text
  class Table
    class Cell
      # visible width: without terminal escapes
      def width
        value.gsub(/\033\[[^m]+m/, '').length
      end

      def to_s
        invisible = value.length - width
      ([' ' * table.horizontal_padding]*2).join case align
        when :left
          value.ljust cell_width
          value.ljust cell_width+invisible
        when :right
          value.rjust cell_width
          value.rjust cell_width+invisible
        when :center
          value.center cell_width
          value.center cell_width+invisible
        end
      end
    end
  end
end

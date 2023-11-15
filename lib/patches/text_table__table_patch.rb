# frozen_string_literal: true

# Monkey patching column widths to take into account cell length not including terminal escapes
# Thank you to https://github.com/mikecarlton-illumio/text-table for solving this problem
module Text
  class Table
    def column_widths
      @column_widths ||= \
      all_text_table_rows.reject {|row| row.cells == :separator}.map do |row|
        row.cells.map {|cell| [(cell.width/cell.colspan.to_f).ceil] * cell.colspan}.flatten
      end.transpose.map(&:max)
    end
  end
end

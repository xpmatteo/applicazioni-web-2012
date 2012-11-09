require "minitest/autorun"
require_relative "../lib/plain_text_printer"

class PlainTextPrinterTest < MiniTest::Unit::TestCase
  def setup
    @printer = PlainTextPrinter.new(3)
  end
  
  def test_produces_fixed_width_columns
    row = ReportRow.new
    row.add_cell "a"
    row.add_cell "b"
    @printer.print_headings ["XYZ", "Z"]
    @printer.print_row row
    assert_equal "XYZ  Z\n  a  b\n", @printer.to_s
  end
  
  def test_overflow_column
    @printer.print_headings ["abcde", "x"]
    assert_equal "abcde  x\n", @printer.to_s
  end
end

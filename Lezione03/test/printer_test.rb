require "minitest/autorun"
require_relative "../lib/report"

class PrinterTest < MiniTest::Unit::TestCase
  def setup
    @printer = FixedColumnWidthPrinter.new(3)
  end
  
  def test_produces_fixed_width_columns
    @printer << ["XYZ", "Z"]
    @printer << ["a", "b"]
    assert_equal "XYZ  Z\n  a  b\n", @printer.to_s
  end
  
  def test_overflow_column
    @printer << ["abcde", "x"]
    assert_equal "abcde  x\n", @printer.to_s
  end
end

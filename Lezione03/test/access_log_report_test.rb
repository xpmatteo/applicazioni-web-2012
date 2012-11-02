require "minitest/autorun"
require_relative "../lib/report"

class DateCell < ReportCell
  def <<(line)
    @value = line[:date]
  end
end

class StatusCounter2xx < ReportCell
  def initialize
    @value = 0
  end
  
  def << (line)
    @value += 1 if (200..299).include?(line[:status])
  end
end


class ReportTest < MiniTest::Unit::TestCase
  def setup
    @report = Report.new
    @report.group_by :date
    @report.add_column "Date", DateCell
    @report.add_column "Status 2xx", StatusCounter2xx
  end
  
  def test_add_one_access
    @report << {:date => "1/2/2012", :status => 200}
    assert_equal [a_report_row(:date => "1/2/2012", :count_2xx => 1)], @report.rows
  end
  
  def test_returns_one_row_per_date
    @report << {:date => "1/2/2012", :status => 200}
    @report << {:date => "2/2/2012", :status => 200}
    assert_equal [
      a_report_row(:date => "1/2/2012", :count_2xx => 1),
      a_report_row(:date => "2/2/2012", :count_2xx => 1),
      ], @report.rows
  end
  
  def test_adds_2xx_accesses
    @report << {:date => "1/2/2012", :status => 200}
    @report << {:date => "1/2/2012", :status => 201}
    assert_equal [
      a_report_row(:date => "1/2/2012", :count_2xx => 2),
      ], @report.rows
  end
  
  private
  
  def a_report_row(data)
    row = ReportRow.new
    row.add_cell ReportCell.new(data[:date])
    row.add_cell ReportCell.new(data[:count_2xx] || 0)
    return row
  end
end

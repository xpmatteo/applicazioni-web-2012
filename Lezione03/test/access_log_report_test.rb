require "minitest/autorun"
require_relative "../lib/report"

class DateCell < ReportCell
  def <<(line)
    @value = line[:date]
  end
end

class StatusCounter < ReportCell
  def initialize(range)
    @range = range 
    @value = 0
  end
  
  def << (line)
    @value += 1 if @range.include?(line[:status])
  end
end

class StatusCounter2xx < StatusCounter
  def initialize
    super(200..299)
  end
end

class StatusCounter3xx < StatusCounter
  def initialize
    super(300..399)
  end
end

class StatusCounter4xx < StatusCounter
  def initialize
    super(400..499)
  end
end

class StatusCounter5xx < StatusCounter
  def initialize
    super(500..599)
  end
end


class ReportTest < MiniTest::Unit::TestCase
  def setup
    @report = Report.new
    @report.add_column "Date", DateCell
    @report.add_column "Status 2xx", StatusCounter2xx
    @report.add_column "Status 3xx", StatusCounter3xx
    @report.add_column "Status 4xx", StatusCounter4xx
    @report.add_column "Status 5xx", StatusCounter5xx
  end
  
  def test_add_one_access
    @report << an_access(date: "1/2/2012", status: 200)
    assert_equal [a_report_row(date: "1/2/2012", count_2xx: 1)], @report.rows
  end
  
  def test_returns_one_row_per_date
    @report << an_access(date: "1/2/2012", status: 200)
    @report << an_access(date: "2/2/2012", status: 200)
    assert_equal [
      a_report_row(date: "1/2/2012", count_2xx: 1),
      a_report_row(date: "2/2/2012", count_2xx: 1),
      ], @report.rows
  end
  
  def test_adds_2xx_accesses
    @report << an_access(date: "1/2/2012", status: 200)
    @report << an_access(date: "1/2/2012", status: 201)
    assert_equal [
      a_report_row(date: "1/2/2012", count_2xx: 2),
      ], @report.rows
  end
  
  def test_adds_3xx_accesses
    @report << an_access(date: "1/2/2012", status: 301)
    @report << an_access(date: "1/2/2012", status: 302)
    assert_equal [
      a_report_row(date: "1/2/2012", count_3xx: 2),
      ], @report.rows
  end
  
  def test_adds_4xx_accesses
    @report << an_access(date: "1/2/2012", status: 404)
    @report << an_access(date: "1/2/2012", status: 401)
    assert_equal [
      a_report_row(date: "1/2/2012", count_4xx: 2),
      ], @report.rows
  end

  def test_adds_5xx_accesses
    @report << an_access(date: "4/2/2012", status: 500)
    @report << an_access(date: "4/2/2012", status: 599)
    assert_equal [
      a_report_row(date: "4/2/2012", count_5xx: 2),
      ], @report.rows
  end
  
  def test_acceptance
    @report << an_access(date: "29/Jul/2011", status: 200)
    @report << an_access(date: "29/Jul/2011", status: 304)
    @report << an_access(date: "29/Jul/2011", status: 201)
    @report << an_access(date: "29/Jul/2011", status: 304)
    @report << an_access(date: "29/Jul/2011", status: 200)
    @report << an_access(date: "30/Jul/2011", status: 404)
    @report << an_access(date: "31/Jul/2011", status: 502)
    @report << an_access(date: "01/Aug/2011", status: 401)

    assert_equal [
      a_report_row(date: "29/Jul/2011", count_2xx: 3, count_3xx: 2),
      a_report_row(date: "30/Jul/2011", count_4xx: 1),
      a_report_row(date: "31/Jul/2011", count_5xx: 1),
      a_report_row(date: "01/Aug/2011", count_4xx: 1),
    ], @report.rows
  end
  
  private
  
  def an_access(access_data)
    access_data
  end
  
  def a_report_row(data)
    row = ReportRow.new
    row.add_cell ReportCell.new(data[:date])
    row.add_cell ReportCell.new(data[:count_2xx] || 0)
    row.add_cell ReportCell.new(data[:count_3xx] || 0)
    row.add_cell ReportCell.new(data[:count_4xx] || 0)
    row.add_cell ReportCell.new(data[:count_5xx] || 0)
    return row
  end
end

class FixedWidthTextOutput
  def initialize(width)
    @width = width
    @output = ""
  end

  def <<(row)
    print_row(row)
  end
  
  def to_s
    @output
  end
  
  private
  
  def print_row(row)
    row.each do |field|
      print_field(field)
    end
    @output += "\n"    
  end
  
  def print_field(content)
    @output += sprintf("%#{@width}s", content)
  end
end

class OutputTest < MiniTest::Unit::TestCase
  def test_case_name
    output = FixedWidthTextOutput.new(3)
    output << ["XY", "Z"]
    output << ["a", "b"]
    assert_equal " XY  Z\n  a  b\n", output.to_s
  end
end

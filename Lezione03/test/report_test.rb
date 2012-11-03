require "minitest/autorun"
require "stringio"
require_relative "../lib/access_log"
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
    @report.add_column "2xx", StatusCounter2xx
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

  def test_reads_from_file
    data = <<-EOF
212.97.38.66 - - [21/Mar/2006:11:21:46 +0100] "GET / HTTP/1.1" 200 6482 "-" "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en) AppleWebKit/417.9 (KHTML, like Gecko) Safari/417.8"
212.97.38.66 - - [21/Mar/2006:11:21:48 +0100] "GET /insubria_small.png HTTP/1.1" 200 30274 "http://essap.dicom.uninsubria.it/" "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en) AppleWebKit/417.9 (KHTML, like Gecko) Safari/417.8"
    EOF
    file = AccessLog.new(StringIO.new(data))
    
    @report.read file
    
    assert_equal [
      a_report_row(:date => "21/Mar/2006", :count_2xx => 2),
      ], @report.rows
  end
  
  def test_prints_on_printer
    @report << {:date => "1/2/2012", :status => 200}
    @report << {:date => "1/2/2012", :status => 201}

    printer = PlainTextPrinter.new(8)
    @report.print_on printer

    expected = <<-EOF
    Date     2xx
1/2/2012       2
    EOF
    
    assert_equal expected, printer.to_s
  end
  
  private
  
  def a_report_row(data)
    row = ReportRow.new
    row.add_cell ReportCell.new(data[:date])
    row.add_cell ReportCell.new(data[:count_2xx] || 0)
    return row
  end
end

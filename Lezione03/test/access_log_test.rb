require "minitest/autorun"
require "stringio"

require_relative "../lib/access_log"

class AccessLogTest < MiniTest::Unit::TestCase
  
  def setup
    sample_rows = <<-EOF
212.97.38.66 - - [21/Mar/2006:11:21:46 +0100] "GET / HTTP/1.1" 200 6482 "-" "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en) AppleWebKit/417.9 (KHTML, like Gecko) Safari/417.8"
123.123.12.11 - - [22/Mar/2006:11:21:48 +0100] "GET /insubria_small.png HTTP/1.1" 200 30274 "http://essap.dicom.uninsubria.it/" "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en) AppleWebKit/417.9 (KHTML, like Gecko) Safari/417.8"
    EOF
    
    @log = AccessLog.new(StringIO.new(sample_rows))    
  end
  
  def test_reads_all_lines
    assert_not_nil @log.get_line, "first line"
    assert_not_nil @log.get_line, "second line"
    assert_nil @log.get_line
  end

  def test_reads_fields
    line = @log.get_line
    assert_equal "21/Mar/2006", line[:date]
    assert_equal "/", line[:path]
    assert_equal "212.97.38.66", line[:ip_address]
    assert_equal 200, line[:status]
    assert_equal 6482, line[:bytes_sent]
  end
  
  private
  
  def assert_not_nil(something, message="Expected to be nil")
    assert something, message
  end
end
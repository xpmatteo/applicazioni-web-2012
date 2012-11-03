#!/usr/bin/env ruby

require_relative "lib/report"
require_relative "lib/access_log"

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

class AccessLogReport < Report
  def initialize
    super
    self.group_by :date
    self.add_column "Date", DateCell
    self.add_column "Status 2xx", StatusCounter2xx    
    self.add_column "Status 3xx", StatusCounter3xx    
    self.add_column "Status 4xx", StatusCounter4xx    
    self.add_column "Status 5xx", StatusCounter5xx    
  end
end


access_log = AccessLog.new(File.open("access_log", "r"))
report = AccessLogReport.new
printer = FixedColumnWidthPrinter.new(12)

report.read access_log
report.print_on(printer)

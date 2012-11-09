
require_relative "lib/report"
require_relative "lib/access_log"
require_relative "lib/plain_text_printer"

class DateCell < ReportCell
  def <<(line)
    @value = line.date
  end
end

class StatusCounter < ReportCell
  def initialize(min, max)
    @min = min
    @max = max
    @value = 0
  end
  
  def << (line)
    status = line.status
    if status >= @min && status <= @max
      @value += 1 
    end
  end
end

class StatusCounter2xx < StatusCounter
  def initialize
    super(200, 299)
  end
end

class StatusCounter3xx < StatusCounter
  def initialize
    super(300, 399)
  end
end

class StatusCounter4xx < StatusCounter
  def initialize
    super(400, 499)
  end
end


report = Report.new
report.add_column "Date", DateCell
report.add_column "Status 2xx", StatusCounter2xx    
report.add_column "Status 3xx", StatusCounter3xx    
report.add_column "Status 4xx", StatusCounter4xx    

access_log = AccessLog.new(File.open("access_log", "r"))
printer = PlainTextPrinter.new(12)

report.read(access_log)
report.print_on(printer)
puts printer.to_s

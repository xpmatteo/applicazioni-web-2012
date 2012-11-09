class AccessLog
  def initialize(file)
    @file = file
  end
  
  def get_line
    line = @file.gets
    if line.nil?
      nil
    else
      AccessLogLine.new(line)
    end
  end  
end

class AccessLogLine
  def initialize(text)
    @text = text
  end
  
  def date
    match(/\d\d\/\w\w\w\/\d\d\d\d/)
  end
  
  def status
    token_number(8).to_i
  end

  def ip_address
    token_number(0)
  end
  
  def bytes_sent
    token_number(9).to_i
  end
  
  def path
    token_number(6)
  end
  
  private 
  
  def match(regexp)
    @text.match(regexp)[0]
  end  
  
  def token_number(n)
    @text.split(" ")[n]
  end
end
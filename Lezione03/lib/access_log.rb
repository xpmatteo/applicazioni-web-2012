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
    @fields = { 
      :date => match(/\d\d\/\w\w\w\/\d\d\d\d/), 
      :path => token_number(6), 
      :ip_address => token_number(0),
      :status => token_number(8).to_i,
      :bytes_sent => token_number(9).to_i,
    }    
  end
  
  def [](key)
    @fields[key]
  end
  
  private 
  
  def match(regexp)
    @text.match(regexp)[0]
  end  
  
  def token_number(n)
    @text.split(" ")[n]
  end
end
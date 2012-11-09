class PlainTextPrinter
  def initialize(width)
    @width = width
    @output = ""
  end
  
  def print_headings(headings)
    print_array(headings)
  end

  def print_row(row)
    print_array(row.cells)
  end
  
  def to_s
    @output
  end
  
  private
  
  def print_array(elements)
    elements.each do |field|
      print_field(field.to_s)
    end
    @output += "\n"    
  end
  
  def print_field(content)
    padding = spaces(@width - content.length)
    @output += padding + content
  end
  
  def spaces(length)
    result = ""
    while length > 0
      result += " "
      length -= 1
    end
    return result
  end
end

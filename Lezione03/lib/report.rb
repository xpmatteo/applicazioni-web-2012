
class ReportCell
  def initialize(value=nil)
    @value = value
  end

  def ==(other)
    self.to_s == other.to_s
  end
  
  def to_s
    @value.to_s
  end
end

class ReportRow
  attr_accessor :cells
  
  def initialize
    @cells = []
  end
  
  def add_cell(cell)
    @cells << cell
  end
  
  def << (line)
    @cells.each do |cell|
      cell << line
    end
  end
  
  def ==(other)
    @cells == other.cells
  end
end

class Report
  def initialize
    @column_headings = []
    @cell_classes = []
    @rows = {}
  end
  
  def << (line)
    row_for(line) << line
  end
  
  def rows
    @rows.values
  end
  
  def add_column heading, klass
    @column_headings << heading
    @cell_classes << klass
  end
  
  def read(file)
    while (line = file.get_line)
      self << line
    end
  end
  
  def print_on(printer)
    printer.print_headings @column_headings
    rows.each do |row|
      printer.print_row row
    end
  end
  
  private
  
  def row_for(line)
    key = line.date
    unless @rows.key?(key)
      @rows[key] = new_row
    end
    @rows[key]
  end
  
  def new_row
    row = ReportRow.new
    @cell_classes.each do |column|
      row.add_cell column.new        
    end
    row
  end
end

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
    if length > 0
      " " * length
    else
      ""
    end
  end
end

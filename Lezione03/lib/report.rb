
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
  
  def group_by(key)
    @group_by_key = key    
  end
  
  private
  
  def row_for(line)
    key = line[@group_by_key]
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

class FixedColumnWidthPrinter
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

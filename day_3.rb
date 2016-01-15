class ReadInput
  
  def initialize(file_name)
    result = 0
    @file_name = file_name
  end

  def parse_line(line)
    return 0
  end

  def read_file
    file = File.new(@file_name, "r")
    result = 0
    while (line = file.gets)
        result += parse_line(line)        
    end
    file.close
    return result
  end


end
class Coordinate
  attr_accessor :x,:y
  def initialize(x,y)
    @x = x
    @y = y
  end

  def ==(o)
    (o.x == @x) && (o.y == y)
  end
end

class VisitingHouse < ReadInput

  def next_coordinate(ch, coordinate)

    return Coordinate.new(coordinate.x, coordinate.y+1) if ch == '^'
    return Coordinate.new(coordinate.x, coordinate.y-1) if ch == 'v'
    return Coordinate.new(coordinate.x+1, coordinate.y) if ch == '>'
    return Coordinate.new(coordinate.x-1, coordinate.y) if ch == '<' 
  end

  def parse_line(line)
    current_coordinate = Coordinate.new(0,0)
    homes = [current_coordinate]
    line.chars.each do |ch|
      current_coordinate = next_coordinate(ch, current_coordinate)
      homes << current_coordinate if !homes.include?(current_coordinate)
    end
    homes.count
  end
end
vh = VisitingHouse.new("day_3.txt")
puts vh.read_file
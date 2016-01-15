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
  def visiting_house(line)
    current_coordinate = Coordinate.new(0,0)
    homes = [current_coordinate]
    line.chars.each do |ch|
      current_coordinate = next_coordinate(ch, current_coordinate)
      homes << current_coordinate if !homes.include?(current_coordinate)
      puts current_coordinate.x.to_s+" "+ current_coordinate.y.to_s
    end
    return homes
  end


  def parse_line(line)
    count = 0 
    line_santa = ""
    line_robo = ""
    line.chars.each do |ch|
      if (count%2 == 1)
        line_robo << ch
      else
        line_santa << ch
      end
      count = count+1
    end
    puts line_santa
    puts line_robo
    homes_santa = visiting_house(line_santa)
    homes_robo = visiting_house(line_robo)
    homes_robo.each do |coordinate|
      homes_santa << coordinate if !homes_santa.include? coordinate
    end
    return homes_santa.count
  end
end
vh = VisitingHouse.new("day_3.txt")
puts vh.read_file
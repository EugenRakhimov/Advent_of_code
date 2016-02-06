class ReadInput
  
  def initialize(file_name)
    @result = []
    @file_name = file_name
  end

  def parse_line(line)
    return 0
  end

  def read_file
    file = File.new(@file_name, "r")
    while (line = file.gets)      
      @result << parse_line(line.strip)        
    end
    file.close
    return @result
  end

end

class Deer
  attr_accessor :name, :fly_speed, :fly_time, :rest_time, :points
  def initialize(name, fly_speed, fly_time, rest_time)
    @name = name
    @fly_speed = fly_speed
    @fly_time = fly_time
    @rest_time = rest_time
    @points = 0        
  end
  def move_for_time(time)
    cycles = time/(@fly_time+@rest_time) 
    left_time = time - (@fly_time+@rest_time)*cycles    
    distance = @fly_time*cycles*@fly_speed
    distance += @fly_time*@fly_speed if left_time > @fly_time
    distance += left_time*@fly_speed if left_time <= @fly_time
    distance
  end
  def award_point
    @points += 1
  end
end

class ReadDears < ReadInput
  def parse_line(line)
    arr=line.split(" ")
    Deer.new(arr[0], arr[3].to_i, arr[6].to_i, arr[13].to_i)    
  end  
end

class CalculateDearsDistance

  def initialize
    rd = ReadDears.new("day_14.txt")
    @dears = rd.read_file       
  end
  def max_distance(time)
    distance = 0
    @dears.each do |dear|
      dear_distance = dear.move_for_time(time)
      distance = dear_distance if distance < dear_distance
    end
    distance
  end
  def max_points(time)
    (time+1).times do |i|
      distance = 0
      @dears.each do |dear|
        dear_distance = dear.move_for_time(i)
        distance = dear_distance if distance < dear_distance
      end
      @dears.each do |dear|
        dear_distance = dear.move_for_time(i)
        dear.award_point if distance == dear_distance
      end
    end
    @dears.sort{|dear, dear2| dear2.points <=> dear.points}[0].points-1
  end

end

calcDears = CalculateDearsDistance.new
p calcDears.max_distance(2503)
p calcDears.max_points(2503)
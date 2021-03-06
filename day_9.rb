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
class Distance
  attr_accessor :city1, :city2, :distance
  def initialize(city1, city2, distance)
    @city1 = city1
    @city2 = city2
    @distance = distance
  end
end
class ReadDistance < ReadInput
  def parse_line(line)
    arr=line.split(" ")
    Distance.new(arr[0], arr[2], arr[4].to_i)    
  end  
end
class CalcMinDistance
  def initialize
    rd = ReadDistance.new("day_9.txt")
    @distances = rd.read_file
    @max_distance = 0
    @cities = cities_list
  end
  def cities_list
     cities = []
     @distances.each do |distance|       
       cities << distance.city1 if (!cities.include? distance.city1)
       cities << distance.city2 if (!cities.include? distance.city2)
     end
     cities
  end
  def check_pair(distance, city1, city2)
    return true if ((distance.city1 == city1) && (distance.city2 == city2))
    return true if ((distance.city1 == city2) && (distance.city2 == city1))
    return false
  end  
  def get_distance(city1, city2)
    return 0 if city2 == ""
    @distances.each do |distance|
      return distance.distance if (check_pair(distance, city1, city2))
    end
  end
  def check_direction(visited_cities = [], current_distance=0, last_city="")
    return @max_distance = current_distance if ((visited_cities.count == @cities.count) && (current_distance > @max_distance))
    return @max_distance if (visited_cities.count == @cities.count) 
     @cities.each do |city|

      if !visited_cities.include?(city)
        to_visit = Array.new(visited_cities)
        to_visit << city
        new_distance = current_distance+ get_distance(city, last_city)
        check_direction(to_visit, new_distance, city) 
      end
     end
    
  end
  def max_distance
    @max_distance
  end
end
cMinDistance = CalcMinDistance.new
p cMinDistance.check_direction
p cMinDistance.max_distance


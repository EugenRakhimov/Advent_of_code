class Bulb
  attr_accessor :state
  def initialize
    @state = false
  end
  
  def on    
    @state = true 
  end

  def off
    @state = false 
  end

  def toggle
    @state = !@state
  end

  def is_on?
    @state
  end
  def get_command(command)
     toggle if (command =="toggle")
     on if (command == "on")
     off if (command == "off")
  end

end

class Bulbs_controller
  
  def initialize(directions_file)
    @bulbs = Array.new(1000){Array.new(1000) { Bulb.new }}
    @file = File.new(directions_file, "r")
  end
  def parse_coordinate(coordinate)
    arr = coordinate.split(",").map { |e| e.to_i }
  end
  def send_directions(left_top, right_bottom,command)
     left_corner = parse_coordinate(left_top)
     right_corner = parse_coordinate(right_bottom)
     for i in (left_corner[0]..right_corner[0]) do
       for j in (left_corner[1]..right_corner[1]) do 
        @bulbs[i][j].get_command(command)
       end
     end
  end

  def parse_direction(line)
    arr = line.split(' ')    
    send_directions(arr[1], arr[3],"toggle") if (arr[0] == "toggle")
    send_directions(arr[2], arr[4],"on") if (arr[0] == "turn") and (arr[1] == "on")
    send_directions(arr[2], arr[4],"off") if (arr[0] == "turn") and (arr[1] == "off")    
  end

  def get_directions 
    while (line = @file.gets)      
      parse_direction(line)        
    end
    @file.close    
  end

  def count_turned_on
    @bulbs.flatten.select{|t| t.is_on?}.count
  end

end
bc = Bulbs_controller.new("day_6.txt")
bc.get_directions
puts bc.count_turned_on
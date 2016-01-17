class Wire
  attr_accessor :name, :signals
end
class Direction
  attr_accessor :name, :first_wire, :second_wire, :signal, :operation
  def initialize(name, first_wire, second_wire, signal, operation)
    @name = name
    @first_wire = first_wire
    @second_wire = second_wire
    @signal = signal
    @operation = operation
  end

end
class Wire_Directions_Reader
  
  def initialize(directions_file)   
    @file = File.new(directions_file, "r")
    @directions = []
  end
  def parse_coordinate(coordinate)
    arr = coordinate.split(",").map { |e| e.to_i }
  end
  def parse_direction(line)
    arr = line.split(' ')      
    return Direction.new(arr[2],"line","line",arr[0].to_i,"SET")  if ((arr[1] == "->")&&(arr[0].to_i.to_s == arr[0]))
    return Direction.new(arr[2],arr[0],"line",-1,"TRF")  if (arr[1] == "->")
   
    return Direction.new(arr[3], arr[1],"line",-1,"NOT")  if (arr[0] == "NOT")
    return Direction.new(arr[4], arr[0],arr[2],-1,arr[1]) 
  end

  def get_directions 
    while (line = @file.gets)      
      @directions << parse_direction(line)        
    end
    @file.close  
    return @directions  
  end

end
class WireControler
  def initialize
    @wires = []
    dr = Wire_Directions_Reader.new("day_7.txt")
    @directions = dr.get_directions
  end
  def print_directions
    ready_directions = get_ready_directions
    ready_directions.each do |direction|
      puts direction
    end
  end
  def do_not_command(direction)
       
  end  
  def execute_direction(direction)
    first_signal = get_signal(direction.first_wire)
    return direction.signal = (~first_signal) if (direction.operation == "NOT")
    return direction.signal = first_signal if (direction.operation == "TRF")
    second_signal = get_signal(direction.second_wire)       
    return direction.signal = (first_signal&second_signal) if direction.operation == "AND"
    return direction.signal = (first_signal|second_signal) if direction.operation == "OR"
    return direction.signal = (first_signal << second_signal) if direction.operation == "LSHIFT"
    return direction.signal = (first_signal >> second_signal) if direction.operation == "RSHIFT"
    
  end
  def do_directions(ready_directions)
    ready_directions.each do |direction|
      execute_direction(direction)
      # p direction
    end
  end
  def find_a_signal   
    while (get_signal("a") == -1) do
      ready_directions = get_ready_directions
      do_directions(ready_directions)
      # p @directions
    end
    get_signal("a")    
  end
  def get_signal(name)
    return name.to_i if name.to_i.to_s == name
    # puts name
    direction = @directions.select{|d| d.name == name}[0]    
    return direction.signal.to_i 
  end
  def ready(direction)
    # exclude already calculated
    return false if direction.signal != -1
    
    first_signal = get_signal(direction.first_wire) if (direction.first_wire!="line")
    
    return false if (first_signal == -1)
    return true if ((first_signal != -1)&& ((direction.operation == "NOT")||(direction.operation == "TRF")))
    second_signal = get_signal(direction.second_wire)
    
    return false if (second_signal == -1)    
    return true if  (second_signal != -1)
    return false
  end
  def get_ready_directions
    ready_directions = []
    @directions.each do |direction|
      ready_directions << direction if ready(direction)
      p direction
    end
    ready_directions
  end

end
wireController = WireControler.new
wireController.print_directions
# p wireController.get_signal("a")
p wireController.find_a_signal
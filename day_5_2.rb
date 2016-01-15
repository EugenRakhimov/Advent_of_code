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
class NaughtyStrings2 < ReadInput
  def twice_with_space(line)
    arr = line.chars    
    arr.count.times do |i|
      return true if (i < arr.count-2)&&(arr[i]== arr[i+2])  
    end 
    return false
  end
  def twice_combination(line)    
    line[/(\w\w).*\1/]     
  end
  def nice(line)
    return true if (twice_combination(line)&&twice_with_space(line))
    return false    
  end

  def parse_line(line)
    return 1 if nice(line)
    return 0
  end
end

ns = NaughtyStrings2.new("day_5.txt")
puts ns.read_file
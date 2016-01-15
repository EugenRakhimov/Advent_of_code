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
class NaughtyStrings < ReadInput

  def vowels(line)    
    return true if (2 < line.chars.select {|ch| ['a','e','i','o','u'].include?ch}.count)
    return false
  end

  def twice_in_row(line)
    arr = line.chars    
    arr.count.times do |i|
      return true if (i < arr.count-1)&&(arr[i]== arr[i+1])  
    end 
    return false
  end
  def not_include(line)
    return false if line.include?"ab"
    return false if line.include?"cd"
    return false if line.include?"pq"
    return false if line.include?"xy"
    return true
  end
  def nice(line)
    return true if (vowels(line)&&twice_in_row(line)&&not_include(line))
    return false    
  end

  def parse_line(line)
    return 1 if nice(line)
    return 0
  end
end

ns = NaughtyStrings.new("day_5.txt")
puts ns.read_file
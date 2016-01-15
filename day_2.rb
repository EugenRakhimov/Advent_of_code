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

class WrappingPaper < ReadInput
  def parse_line(line)
      array = line.split('x')      
      first_side =  array[0].to_i*array[1].to_i
      smallest_side = first_side
      second_side = array[1].to_i*array[2].to_i
      smallest_side = second_side if second_side < smallest_side 
      fird_side = array[0].to_i*array[2].to_i
      smallest_side = fird_side if fird_side < smallest_side       
      return first_side*2+second_side*2+fird_side*2+smallest_side
  end
end
class Ribbon < ReadInput
  def parse_line(line)
    array = line.split('x').map { |x| x.to_i }.sort
    array[0]*2+array[1]*2+array[0]*array[1]*array[2]
  end
end

wr = WrappingPaper.new("day_2.txt")
ribbon = Ribbon.new("day_2.txt")
puts ribbon.read_file
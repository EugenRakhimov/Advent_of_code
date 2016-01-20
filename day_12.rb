require 'json'

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
class JsonFile < ReadInput
  def parse_line(line)
     my_hash = JSON.parse(line) 
  end
  def calculate_sum
    my_hash = @result[0]
    @sum = get_sum(my_hash)
  end
  def get_sum(current_obj)
   sum = 0
    return 0 if ((current_obj.is_a? Hash)&& (current_obj.has_value?"red"))
   for_sum = current_obj.to_a.flatten
   for_sum.each do |element|
    if element.is_a? Enumerable
      sum += get_sum(element)
    else
      sum += element.to_i  
    end

   end
    sum
  end
end

jf = JsonFile.new("day_12.txt")
jf.read_file
p jf.calculate_sum
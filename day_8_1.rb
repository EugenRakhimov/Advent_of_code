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
      result += parse_line(line.strip)        
    end
    file.close
    return result
  end

end
class StringCounter <ReadInput
  def unescape_escapes(s)
    s = s.gsub("\\\\", "\\") #Backslash
    s = s.gsub('\\"', '"')  #Double quotes
    s = s.gsub("\\'", "\'")  #Single quotes
    s = s.gsub("\\a", "\a")  #Bell/alert
    s = s.gsub("\\b", "\b")  #Backspace
    s = s.gsub("\\r", "\r")  #Carriage Return
    s = s.gsub("\\n", "\n")  #New Line
    s = s.gsub("\\s", "\s")  #Space
    s = s.gsub("\\t", "\t")  #Tab
    # s = s.gsub("")
  end
  def add_escapes(line)
     line.gsub(/(\\|")/, '12')
  end

  def parse_line(line)
    
    # puts "string1: #{eval("puts  + @string1 + ")}"
    line2 =add_escapes(line)
    # eval("puts "+line)
    puts line.length
    puts line2.length
    puts line
    puts line2
    return (line2.length+2 - line.length)
  end
end

sc = StringCounter.new("day_8.txt")
puts sc.read_file
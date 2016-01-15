def check(ch)
  return 1 if ch == '('
  return -1 if ch == ')'  
end
def parse_line(line)
  result = 0
  line.chars.each do |ch|
    result = result + check(ch)
  end
  result
end
def find_basement(line)
   result = 0
   count = 0
   line.chars.each do |ch|
    result = result + check(ch)
    count = count+1
      if (result < 0) 
        return count
      end
    end

end

file = File.new("day_1.txt", "r")
result = 0
while (line = file.gets)
    result += parse_line(line)
    puts find_basement(line)
end
file.close
puts result
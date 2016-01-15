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

file = File.new("day_1.txt", "r")
result = 0
while (line = file.gets)
    result += parse_line(line)
end
file.close
puts result
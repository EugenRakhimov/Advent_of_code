class LookAndSay

  def initialize(sequence)
    @sequence = sequence.to_s.chars.map { |elem| elem.to_i }
    p @sequence
  end
  def look_and_say
    new_sequence = []
    current_number = @sequence[0]
    current_count = 1    
    for i in 1..(@sequence.count-1)  do
      if @sequence[i] != current_number
        new_sequence << current_count
        new_sequence << current_number
        current_count = 1
        current_number = @sequence[i]
      else
        current_count += 1
      end
    end
    new_sequence << current_count
    new_sequence << current_number
    @sequence = new_sequence
  end
  def current_sequence
    @sequence.join
  end

end
ls = LookAndSay.new("1113222113")
40.times do
  ls.look_and_say
  p ls.current_sequence
end
p ls.current_sequence.length


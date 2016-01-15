require 'digest'
def calculate_hash(number)
  md5 = Digest::MD5.new
  md5 << 'bgvyzdsv'
  md5 << number.to_s
  md5.hexdigest 
end
def check_hash(hash)
   if (hash[0,6] == "000000")
      return true
    else
      return false
   end
end
def find_a_number
  number = 1
  while(!check_hash(calculate_hash(number)))

    number = number+1
    
  end
  number
end
puts find_a_number
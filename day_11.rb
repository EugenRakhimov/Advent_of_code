class SantaPassword
  
  def initialize(current_pass)
    @current_pass = current_pass.chars
  end

  def current_pass
    @current_pass.join
  end
  
  def find_next_pass    
    new_pass = increase_by_1(@current_pass)
    while (!check_pass(new_pass)) do
      new_pass = increase_by_1(new_pass)
    end
    @current_pass = new_pass
  end
  
  def increase_by_1(pass)
    new_pass = Array.new(pass.reverse)    
    for i in 0..7 do
      if (new_pass[i] == 'z')
        # p  new_pass[i]
         new_pass[i] = 'a'
      else 
        # p i       
        new_pass[i] = (new_pass[i].ord+1).chr       
        return new_pass.reverse
      end 
    end
    new_pass.reverse
  end
  def has_sequence(pass)
    for i in 2..7 do
      return true if ((pass[i-2].ord+1 == pass[i-1].ord)&& (pass[i-1].ord+1 == pass[i].ord))
    end
    return false
  end
  def has_two_pairs(pass)
    i = 0    
    pairs_symbols =[]
    while (i < 7) do
       if (pass[i] == pass[i+1])       
        pairs_symbols << pass[i]
        i += 2
       else
        i += 1
       end   
    end
    return true if  (pairs_symbols.uniq.length > 1)
    return false
  end
  def check_pass(pass)
    return false if (pass.include?'i')||(pass.include?'o')||(pass.include?'l')
    return false if !has_sequence(pass)
    return false if !has_two_pairs(pass)
    return true
  end

end

sp = SantaPassword.new('hxbxwxba')
sp.find_next_pass
sp.find_next_pass
p sp.current_pass

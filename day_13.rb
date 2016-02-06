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

class Relation
  attr_accessor :name, :relation, :relative
  def initialize(name, relation_sign, relation_qty, relative)
    @name = name
    @relative = relative
    @relation = (relation_sign == "lose")? -relation_qty : relation_qty
  end
end

class ReadRelation < ReadInput
  def parse_line(line)
    arr=line.split(" ")
    Relation.new(arr[0], arr[2], arr[3].to_i, arr[10].chop)    
  end  
end

class CalculateRelation
  def initialize
    rd = ReadRelation.new("day_13.txt")
    @relations= rd.read_file   
    @max_happines = 0
    @names = names_list
    addMe
  end
  def addMe    
    @names.each do |name|
      @relations.push Relation.new(name,"indifferent",0,"Me")
      @relations.push Relation.new("Me","indifferent",0,name)
    end
    @names.push "Me"
  end

  def names_list
    names = @relations.map { |relation| relation.name }.uniq
  end

  def relation_score(last_name,name)
    @relations.select { |relation| (relation.name == last_name) &&(relation.relative == name) }[0].relation
  end

  def calculate_relation(depth=1,left_names = @names.slice(1,@names.length-1), last_name=@names[0])

    relation_count = 0
    # p left_names
    # p depth
    if depth == @names.count-1
    #   depth == 0
    #   last_name = left_names[0]
    #   relation_count = calculate_relation(depth+1,left_names.delete(last_name),last_name)
    # elsif     
      relation_count = relation_score(last_name,left_names[0]) 
      relation_count += relation_score(left_names[0],last_name) 
      relation_count +=  relation_score(left_names[0],@names[0]) 
      relation_count += relation_score(@names[0],left_names[0])
       p left_names
       p last_name
       p relation_score(last_name,left_names[0]) 
       p relation_score(left_names[0],last_name) 
       p relation_score(left_names[0],@names[0]) 
       p relation_score(@names[0],left_names[0])
       p relation_count
    else
      left_names.each do |name|
        new_names = left_names.select{|n| n != name}
        relation_count_new = relation_score(last_name,name)+relation_score(name,last_name)+calculate_relation(depth+1,new_names,name)
        p relation_count_new
        p last_name
        p name
        p new_names
        relation_count = relation_count_new if relation_count_new > relation_count
      end
    end
    # p relation_count
    # p left_names
    relation_count
  end
  def variants_of_names
     8.times do |i|
       p @names.shuffle
     end
   end

end

calcRel = CalculateRelation.new
p calcRel.calculate_relation
calcRel.variants_of_names

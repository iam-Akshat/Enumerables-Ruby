module Enumerable
    def my_each
        for item in self
            yield(item)
          end
          self
    end
    def my_each_with_index
        index=0;
        for item in self
            yield(item,index)
            index += 1
        end
        self    
    end
    def my_select
        new_array = []
        self.my_each do |item|
            new_array.push(item) if yield(item)

        end
      new_array
    end

    def my_all?(pattern=nil)
        if block_given?
            self.my_each do |item|
                return false if !yield(item)
            end
        elsif pattern 
            self.my_each do |item|
                return false if !item.is_a?(pattern)
            end
        else
            self.my_each do |item|
                return false if !item
            end    
        end
        true       
    end
    def my_any?(pattern=nil)
        if block_given?
            self.my_each do |item|
                return true if yield(item)
            end
        elsif pattern 
            self.my_each do |item|
                return true if item.is_a?(pattern)
            end
        else
            self.my_each do |item|
                return true if item
            end    
        end
        false       
    end
    def my_none? (pattern = nil)
      if ! block_given? && pattern.nil?
        my_each { |item| return true if item}
        return false
      end
      if !block_given? && !pattern.nil?

        if pattern.is_a? (Class)
          my_each { |item| return false if item.class == pattern}
          return true
        end
        if pattern.class == Regexp
          my_each { |item| return false if pattern.match(item)}
          return true
        end

        my_each { |item| return false if item == pattern }
        return true
      end
      my_any? { |item| return false if yield(item)}
      true
  end
  def my_count (num = nil)
    arr = self.class == Array ? self : to_a
    return arr.length unless block_given? || num
    return arr.my_select { |item| item == num }.length if num
    arr.my_select { |item| yield(item)}.length
  end
  def my_map
    self.is_a?(Array) and newObj=[]
    self.is_a?(Hash) and newObj={}
    if block_given?
        self.my_each do |item|
            newObj.is_a?(Array) and newObj.push(yield(item))
            newObj.is_a?(Hash) and newObj[item[0]]=yield(item[1])
        end 
    end
    newObj.length==0 and return self.to_enum(:map)
    newObj
  end
  def my_inject(initial=self[0],sym=nil)
    if block_given?
        self.my_each do |obj|
            initial=yield(initial,obj)
        end
    elsif sym
        case sym.to_s
        when "*"
            self.my_each do |obj|
                initial*=obj
            end
        when "+"
            self.my_each do |obj|
                initial+=obj
            end

        when "-"
            self.my_each do |obj|
                initial-=obj
            end
        when "/"
            self.my_each do |obj|
                initial/=obj
            end
        else
            puts "Invalid symbol"
        end
    end
    initial
  end
end

def multiply_els(list)
  list.my_inject(:*)
end
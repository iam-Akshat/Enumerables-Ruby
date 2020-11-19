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
end

 puts [].none?   
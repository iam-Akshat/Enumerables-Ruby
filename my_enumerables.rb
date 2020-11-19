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
        end
      new_array
    end
end

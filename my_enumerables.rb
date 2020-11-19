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
  end

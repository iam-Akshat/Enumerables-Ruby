module Enumerable
  def my_each
    each do |item|
      yield(item)
    end
    self
  end

  def my_each_with_index
    index = 0
    each do |item|
      yield(item, index)
      index += 1
    end
    self
  end

  def my_select
    new_array = []
    my_each do |item|
      new_array.push(item) if yield(item)
    end
    new_array
  end

  def my_all?(pattern = nil)
    if block_given?
      my_each do |item|
        return false unless yield(item)
      end
    elsif pattern
      my_each do |item|
        return false unless item.is_a?(pattern)
      end
    else
      my_each do |item|
        return false unless item
      end
    end
    true
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each do |item|
        return true if yield(item)
      end
    elsif pattern
      my_each do |item|
        return true if item.is_a?(pattern)
      end
    else
      my_each do |item|
        return true if item
      end
    end
    false
  end

  def my_none?(pattern = nil)
    if !block_given? && pattern.nil?
      my_each { |item| return true if item }
      return false
    end
    if !block_given? && !pattern.nil?

      if pattern.is_a? Class
        my_each { |item| return false if item.class == pattern }
        return true
      end
      if pattern.class == Regexp
        my_each { |item| return false if pattern.match(item) }
        return true
      end

      my_each { |item| return false if item == pattern }
      return true
    end
    my_any? { |item| return false if yield(item) }
    true
end

  def my_count(num = nil)
    arr = self.class == Array ? self : to_a
    return arr.length unless block_given? || num
    return arr.my_select { |item| item == num }.length if num

    arr.my_select { |item| yield(item) }.length
  end

  def my_map(my_proc=nil)
    is_a?(Array) and newObj = []
    is_a?(Hash) and newObj = {}
    
    if block_given?
      my_each do |item|
        newObj.is_a?(Array) and newObj.push(yield(item))
        newObj.is_a?(Hash) and newObj[item[0]] = yield(item[1])
      end
    else
      my_each { |item| newObj.push(my_proc.call(item))}
    end
    end
    newObj.empty? and return to_enum(:map)
    newObj
  end

  def my_inject(initial = self[0], sym = nil)
    if block_given?
      my_each do |obj|
        initial = yield(initial, obj)
      end
    elsif sym
      case sym.to_s
      when '*'
        my_each do |obj|
          initial *= obj
        end
      when '+'
        my_each do |obj|
          initial += obj
        end

      when '-'
        my_each do |obj|
          initial -= obj
        end
      when '/'
        my_each do |obj|
          initial /= obj
        end
      else
        puts 'Invalid symbol'
      end
    end
    initial
  end
end

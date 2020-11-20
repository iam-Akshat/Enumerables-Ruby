module Enumerable
  def my_each
    if 
      each do |item|
        yield(item)
      end
    else
      (return to_enum(:each) unless block_given?)
    self
  end

  def my_each_with_index
    index = 0
      each do |item|
        yield(item, index)
        index += 1
      (return to_enum(:each_with_index) unless block_given?)
        
    end
    self
  end

  def my_select
      new_array = []
      my_each do |item|
        new_array.push(item) if yield(item)
      end
      (return to_enum(:select) unless block_given?)
        
    new_array
  end

  def my_all?(pattern = nil)
    if block_given?
      my_each do |item|
        return false unless yield(item)
      end
    elsif pattern
      if pattern.is_a?(Regexp)
        my_each do |item|
          return false unless pattern.match(item)
        end
      else
        my_each do |item|
          return false unless item.is_a?(pattern)
        end
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
      if pattern.is_a?(Regexp)
        my_each do |item|
          return true if pattern.match(item)
        end
      else
        my_each do |item|
          return true if item.is_a?(pattern)
        end
      end
    else
      my_each do |item|
        return true if item
      end
    end
    false
  end

  def my_none?
    output = true
    my_each do |e|
      output = false if yield e
    end
    output
  end

  def my_count(num = nil)
    arr = self.class == Array ? self : to_a
    return arr.length unless block_given? || num
    return arr.my_select { |item| item == num }.length if num

    arr.my_select { |item| yield(item) }.length
  end

  def my_map(my_proc = nil)
    is_a?(Array) and new_obj = []
    is_a?(Hash) and new_obj = {}

    if block_given?
      my_each do |item|
        new_obj.is_a?(Array) and new_obj.push(yield(item))
        new_obj.is_a?(Hash) and new_obj[item[0]] = yield(item[1])
      end
    elsif my_proc
      my_each do |item|
        new_obj.is_a?(Array) and new_obj.push(my_proc.call(item))
        new_obj.is_a?(Hash) and new_obj[item[0]] = my_proc.call(item[1])
      end
    end

    new_obj.empty? and return to_enum(:map)
    new_obj
  end

  def my_inject(initial = nil, sym = nil)
    if !initial && !block_given?
      puts 'err1'
      raise(LocalJumpError)
    elsif initial.class != Symbol && !block_given? && !initial.is_a?(Numeric)
      puts 'err2'
      raise(LocalJumpError)
    end
    if block_given?
      initial ||= self[0]
      my_each do |obj|
        initial = yield(initial, obj)
      end
    elsif (sym.nil? && initial.class == Symbol) || (sym && initial)
      unless sym && initial
        sym = initial
        initial = self[0]
      end
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
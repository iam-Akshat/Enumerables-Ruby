# rubocop:disable  Metrics/ModuleLength,Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/MethodLength
module Enumerable
  def my_each(&block)
    return to_enum(:each) unless block_given?

    each(&block)
    self
  end

  def my_each_with_index
    index = 0
    return to_enum(:each_with_index) unless block_given?

    each do |item|
      yield(item, index)
      index += 1
    end
    self
  end

  def my_select
    return to_enum(:select) unless block_given?

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
      case pattern
      when Regexp
        my_each do |item|
          return false unless pattern.match(item)
        end
      when Class
        my_each do |item|
          return false unless item.is_a?(pattern)
        end
      else my_each do |item|
        return false unless item == pattern
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
      case pattern
      when Regexp
        my_each do |item|
          return true if pattern.match(item)
        end
      when Class
        my_each do |item|
          return true if item.is_a?(pattern)
        end
      else my_each do |item|
        return true if item == pattern
      end
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
      my_each { |item| return false if item }
      return true
    end
    if !block_given? && !pattern.nil?

      if pattern.is_a? Class
        my_each { |item| return false if item.instance_of?(pattern) }
        return true
      end
      if pattern.instance_of?(Regexp)
        my_each { |item| return false if pattern.match(item) }
        return true
      end

      my_each { |item| return false if item == pattern }
      return true
    end
    my_any? { |item| return false if yield(item) }
    true
  end

  def my_count(num = nil, &block)
    arr = instance_of?(Array) ? self : to_a
    return arr.length unless block_given? || num
    return arr.my_select { |item| item == num }.length if num

    arr.my_select(&block).length
  end

  def my_map(my_proc = nil)
    is_a?(Array) and new_obj = []
    is_a?(Hash) and new_obj = {}
    is_a?(Range) and new_obj = []

    if block_given? && my_proc.nil?
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
    mod_self = self
    mod_self = to_a if is_a?(Range)
    if !initial && !block_given?
      puts 'err1'
      raise(LocalJumpError)
    elsif initial.class != Symbol && !block_given? && !initial.is_a?(Numeric)
      puts 'err2'
      raise(LocalJumpError)
    end
    if block_given?
      a = if initial
            2
          else
            1
          end
      initial ||= mod_self[0]
      my_each do |obj|
        initial = yield(initial, obj) if a > 1
        a += 1
      end
    elsif (sym.nil? && initial.instance_of?(Symbol)) || (sym && initial)
      a = if sym && initial
            2
          else
            1
          end
      unless sym && initial
        sym = initial
        initial = mod_self[0]
      end
      case sym.to_s
      when '*'
        my_each do |obj|
          initial *= obj if a > 1
          a += 1
        end
      when '+'
        my_each do |obj|
          initial += obj if a > 1
          a += 1
        end

      when '-'
        my_each do |obj|
          initial -= obj if a > 1
          a += 1
        end
      when '/'
        my_each do |obj|
          initial /= obj if a > 1
          a += 1
        end
      else
        puts 'Invalid symbol'
      end
    end
    initial
  end
end

def multiply_els(list)
  list.my_inject(:*)
end
# rubocop:enable Metrics/ModuleLength,Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/MethodLength

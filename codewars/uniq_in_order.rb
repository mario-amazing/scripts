def unique_in_order(iterable)
  result = []
  (iterable.is_a?(String) ? iterable.split('') : iterable).each_with_index do |letter, index|
    result << letter if letter != iterable[index+1]
  end

  result
end

def unique_in_order(iterable)
  (iterable.is_a?(String) ? iterable.split('') : iterable).chunk(&:itself).map(&:first)
end

puts unique_in_order('AAAABBBCCDAABBB') == ['A','B','C','D','A','B']
puts unique_in_order('AAAABBBCCDAABBB')

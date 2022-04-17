def delete_nth(order,max_e)
  result = []
  order.each_with_object(Hash.new(0)) { |el, hash|
    next if hash[el] >= max_e
    result << el
    hash[el] += 1
  }
  result
end
puts delete_nth([20,37,20,21], 1) == [20,37,21]

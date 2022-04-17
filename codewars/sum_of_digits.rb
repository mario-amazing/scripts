def digital_root(n)
  while n > 9
    n = n.digits.sum
  end
  n
end

puts digital_root(942) == 6

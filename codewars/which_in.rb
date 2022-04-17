def in_array(a1, a2)
  a1.select { |el| a2.find{ _1.include?(el) } }
end


a1 = ["arp", "live", "strong"]
a2 = ["lively", "alive", "harp", "sharp", "armstrong"]
puts in_array(a1, a2) == ["arp", "live", "strong"]
a1 = ["tarp", "mice", "bull"]
puts in_array(a1, a2) == []

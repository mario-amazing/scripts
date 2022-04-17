def ipsBetween(start, ending)
  ip_sum(ending) - ip_sum(start)
end

def ip_sum(ip)
  ip.split('.').reverse.map.with_index { |el, index| el.to_i*256.pow(index) }.sum
end



puts ipsBetween("10.0.0.0", "10.0.0.50")== 50
puts ipsBetween("20.0.0.10", "20.0.1.0")== 246

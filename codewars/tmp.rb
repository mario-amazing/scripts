def tribonacci(signature,n)
  # return signature if n <= signature.size
  (n - signature.size).times { signature << signature.last(3).sum }
  signature[0...n]
end
 
puts tribonacci([1,1,1],10) == [1,1,1,3,5,9,17,31,57,105]
puts tribonacci([300,200,100],0) == []

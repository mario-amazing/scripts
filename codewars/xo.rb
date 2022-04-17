require "test/unit"

def XO(str)
  str.scan(/x/i).count == str.scan(/o/i).count
end

def XO(str)
  str.downcase!
  str.count('x') == str.count('o')
end

puts XO('xo') == true
puts XO('XO') == true
puts XO('xo0') == true
puts XO('xxxoo') == false
puts XO("xxOo") == true

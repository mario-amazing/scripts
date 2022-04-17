def zero(str="")
  eval "0 #{str}"
end
def one(str="")
  eval "1 #{str}"
end
def two(str="")
  eval "2 #{str}"
end
def three(str="")
  eval "3 #{str}"
end
def four(str="")
  eval "4 #{str}"
end
def five(str="")
  eval "5 #{str}"
end
def six(str="")
  eval "6 #{str}"
end
def seven(str="")
  eval "7 #{str}"
end
def eight(str="")
  eval "8 #{str}"
end
def nine(str="")
  eval "9 #{str}"
end
def plus(str)
 "+ #{str}" 
end
def minus(str)
 "- #{str}" 
end
def times(str)
 "* #{str}" 
end
def divided_by(str)
 "/ #{str}" 
end

puts seven(times(five())) == 35

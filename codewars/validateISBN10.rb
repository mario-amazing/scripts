def validISBN10(isbn)
  return false unless isbn.match(/^\d{9}(\d|X){1}/)
  isbn_map = isbn.delete!('X') ? isbn.chars << 10 : isbn.chars

  isbn_map.map.with_index { |el, index| el.to_i*(index+1) }.sum % 11 == 0
end

puts validISBN10('1112223339') == true;
puts validISBN10('048665088X') == true;
puts validISBN10('1293000000') == true;
puts validISBN10('1234554321') == true;
puts validISBN10('1234512345') == false;
puts validISBN10('1293') == false;
puts validISBN10('X123456788') == false;
puts validISBN10('ABCDEFGHIJ') == false;
puts validISBN10('XXXXXXXXXX') == false;

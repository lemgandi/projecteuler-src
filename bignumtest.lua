-- Test bignum object
require "bignum"

function test_add()
   first=bignum.new("84")
   twost=bignum.new("17")
   sum=first+twost
   print(first:tostring().. " + " .. twost:tostring() .." = " .. sum:tostring())
   twost:set_directly({1})
   sum=first+twost
   print(first:tostring().. " + " .. twost:tostring() .." = " .. sum:tostring())
   first:set_directly({4,8,7,2,1})
   twost:set_directly({3,2,8,7,5})
   sum=first+twost
   print(first:tostring().. " + " .. twost:tostring() .." = " .. sum:tostring())   
   first:set_directly({1})
   sum=first+twost
   print(first:tostring().. " + " .. twost:tostring() .." = " .. sum:tostring())   
end

function test_mul()
   first=bignum.new("1709")
   twost=bignum.new("22")
   sum=first * twost
   print(first:tostring().. " * " .. twost:tostring() .." = " .. sum:tostring())   first:set_directly({8,2})
   twost:set_directly({7,3,4})
   sum=first*twost
   print(first:tostring().. " * " .. twost:tostring() .." = " .. sum:tostring())  
end

--
-- Find sum of digits
--
function test_add_digits()
  bignum_tester = bignum.new("203")
  print("Tester: " .. bignum_tester:tostring() .. " Sum digits: " .. bignum_tester:sum_digits() )
end

-- main line
my_bignum=bignum.new(17)
print("From number: " .. my_bignum:tostring())

test_add()
test_mul()
test_add_digits()




-- Test bignum object
require "bignum"

function test_add()
   first=bignum.new("84")
   twost=bignum.new("17")
   sum=first+twost
   print(first:tostring() .. " + " .. twost:tostring() .." = " .. sum:tostring())
   twost:set_directly({1})
   sum=first+twost
   print(first .. " + " .. twost .." = " .. sum .. "")
   first:set_directly({4,8,7,2,1})
   twost:set_directly({3,2,8,7,5})
   sum=first+twost
   print(first .. " + " .. twost .." = " .. sum .. "")   
   first:set_directly({1})
   sum=first+twost
   print(first .. " + " .. twost .." = " .. sum .. "")   
end

function test_mul()
   first=bignum.new("1709")
   twost=bignum.new("22")
   sum=first * twost
   print(first .. " * " .. twost .." = " .. sum .. "")   
   first:set_directly({8,2})
   twost:set_directly({7,3,4})
   sum=first*twost
   print(first .. " * " ..twost .." = " .. sum .. "")  
end

function test_sub()

   first = bignum.new("108")
   twost = bignum.new("17")

   sum = first - twost
   print(first .. " - " .. twost .. " = " .. sum:tostring() )
   sum = twost - first
   print(twost .. " - " .. first .. " = " .. sum:tostring() )  
   another=bignum.new(1111)
   next=bignum.new(999)
   this_sum=another-next
   print(another .. " - " .. next .. " = " .. this_sum:tostring())
end
--
-- Find sum of digits
--
function test_add_digits()
  bignum_tester = bignum.new("203")
  print("Tester: " .. bignum_tester .. " Sum digits: " .. bignum_tester:sum_digits() .. "" )
end

function test_relations()
   bigint = 2000
   smallint=40
   large = bignum.new(bigint)
   small = bignum.new(smallint)

   print(large .. " > " .. small .. ":" .. tostring(large>small))
   print(small .. " < " .. large .. ":" .. tostring(small<large))
   big = bignum.new(bigint)

   print(big .. "==" .. large .. ":" .. tostring(big == large))
   print(big .. "<=" .. large .. ":" .. tostring(big <= large))
   print(big .. ">=" .. large .. ":" .. tostring(big >= large))

end

function test_neg()
   bigger=bignum.new(12)
   smaller=bignum.new(-12)
   print(bigger .. " > " .. smaller .. " : " .. tostring(bigger > smaller))
   print(bigger .. " < " .. smaller .. " : " .. tostring(bigger < smaller)) 
   print(bigger .. " == " .. smaller .. " : " .. tostring(bigger == smaller))
   bigger=bignum.new(-7)
   print(bigger .. " > " .. smaller .. ":" .. tostring(bigger>smaller))
   print(bigger .. " < " .. smaller .. ":" .. tostring(bigger<smaller))
   print(bigger .. " == " .. smaller ..":" .. tostring(bigger == smaller))
end


function test_div()
   numerator=bignum.new(238)
   denominator=7
   local answer = numerator / denominator
   print( numerator .. "/" .. denominator .." = " .. answer .. "")
   denominator=10
   answer = numerator / denominator
   print( numerator .. "/" .. denominator .. "=" .. answer .. "")
end

-- main line
my_bignum=bignum.new(17)
print("From number:" .. my_bignum .."")

test_add()
test_mul()
test_add_digits()
my_bignum = my_bignum + 1
print("My_bignum + 1 equals: ")
my_bignum:print()
my_bignum = my_bignum * 4
print("My_bignum * 4 equals: ")
my_bignum:print()
test_sub() 
test_relations()
test_neg()
test_div()

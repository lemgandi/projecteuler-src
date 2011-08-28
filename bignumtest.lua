-- Test bignum object
require "bignum"

function test_add()
   local first=bignum.new("84")
   local twost=bignum.new("17")
   local sum=first+twost
   print(first .. " + " .. twost .." = " .. sum .. "")
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
   local first=bignum.new("1709")
   local twost=bignum.new("22")
   local sum=first * twost
   print(first .. " * " .. twost .." = " .. sum .. "")   
   first:set_directly({8,2})
   twost:set_directly({7,3,4})
   sum=first*twost
   print(first .. " * " ..twost .." = " .. sum .. "")  
   local next = bignum.new(2)
   local pow = bignum.new(5)
   sum = next ^ pow
   print(next .. " ^ " .. pow .. " = " .. sum .. "")
   five=bignum.new(5)
   print( five .. " ! is " .. five:factorial() .. " (Should be 120)")
end

function test_sub()

   local first = bignum.new("108")
   local twost = bignum.new("17")

   local sum = first - twost
   print(first .. " - " .. twost .. " = " .. sum:tostring() )
   sum = twost - first
   print(twost .. " - " .. first .. " = " .. sum:tostring() )  
   local another=bignum.new(1111)
   local next=bignum.new(999)
   this_sum=another-next
   print(another .. " - " .. next .. " = " .. this_sum .. "")
end

--
-- Find sum of digits
--
function test_add_digits()
  local bignum_tester = bignum.new("203")
  print("Tester: " .. bignum_tester .. " Sum digits: " .. bignum_tester:sum_digits() .. "" )
end

function test_relations()
   local bigint = 2000
   local smallint=40
   local large = bignum.new(bigint)
   local small = bignum.new(smallint)

   print(large .. " > " .. small .. ":" .. tostring(large>small))
   print(small .. " < " .. large .. ":" .. tostring(small<large))
   local big = bignum.new(bigint)

   print(big .. "==" .. large .. ":" .. tostring(big == large))
   print(big .. "<=" .. large .. ":" .. tostring(big <= large))
   print(big .. ">=" .. large .. ":" .. tostring(big >= large))

end

function test_neg()
   local bigger=bignum.new(12)
   local smaller=bignum.new(-12)
   print(bigger .. " > " .. smaller .. " : " .. tostring(bigger > smaller))
   print(bigger .. " < " .. smaller .. " : " .. tostring(bigger < smaller)) 
   print(bigger .. " == " .. smaller .. " : " .. tostring(bigger == smaller))
   bigger=bignum.new(-7)
   print(bigger .. " > " .. smaller .. ":" .. tostring(bigger>smaller))
   print(bigger .. " < " .. smaller .. ":" .. tostring(bigger<smaller))
   print(bigger .. " == " .. smaller ..":" .. tostring(bigger == smaller))
end


function test_div()
   local numerator=bignum.new(238)
   local denominator=7
   local answer = numerator / denominator
   print( numerator .. " / " .. denominator .." = " .. answer .. "")
   denominator=10
   answer = numerator / denominator
   print( numerator .. " / "  .. denominator .. " = " .. answer .. "")
   answer = numerator % denominator
   print( numerator .. " % " .. denominator .. " = " .. answer .. "")
   denominator=7
   answer = numerator % denominator
   print( numerator .. " % " .. denominator .. " = " .. answer .. "")
   local perfect=bignum.new(289)
   local top,bottom=perfect:sqrt()
   print("Square root of " .. perfect .. " = " .. top .. " " .. bottom .. "")
   perfect=bignum.new(125)
   top,bottom=perfect:root(3)
   print("Cube root of " .. perfect .. " = " .. top .. " " .. bottom .. "")
   perfect = perfect + 17
   top,bottom=perfect:root(3)
   print("Cube root of " .. perfect .. " = " .. top .. " " .. bottom .. "")
end

function test_special()
   twelve=bignum.new(12)
   factors=twelve:find_factors()
   print("Factors of " .. twelve .. ":")
   useful.print_array(factors)
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
test_special()

print("This should fail on an assert")
bignum.zero = bignum.new(44)
print("Bignum.zero:" .. bignum.zero .. "")
-- test_div()
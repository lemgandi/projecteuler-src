--
-- Solve problem 23
--
require "useful"
require "math"

--
-- Does a given number appear in the abundant table?
--
function is_abundant(n,abundant_table)
   local found=useful.bin_search(n,abundant_table,1,#abundant_table)
   retVal=true
   if nil == found then
      retVal=false
   end
   return retVal
end

-- 
-- Can given number be expressed as a sum of two abundant numbers?
--
function is_abundant_sum_of_two(n,abundant_table)

   local kk=1
   local retVal=0
   local nsub=0

   while 0 == retVal and abundant_table[kk] <= math.ceil(n/2)
   do
      nsub=n-abundant_table[kk]
      if is_abundant(nsub,abundant_table)
      then
         retVal=1      
      end
      kk=kk+1        
      if kk > #abundant_table then
         retVal=-1
      end
   end
   if 0 == retVal then
      retVal=-1
   end
   return retVal
end

--
-- Main Line
--

max_noncomposite_sum=20161
-- max_noncomposite_sum=100

abundant_numbers={}

for kk=1,max_noncomposite_sum do
   local ft=useful.find_factors(kk)
   local my_sum=useful.sumtable(ft)
   if my_sum > kk then
      abundant_numbers[#abundant_numbers+1]=kk
   end
end

-- useful.print_array(abundant_numbers)
print("Abundant numbers below " .. max_noncomposite_sum .. ":" .. #abundant_numbers .. "")
--[[
print("7 is abundant: ",is_abundant(7,abundant_numbers))
print("18 is abundant: ", is_abundant(18,abundant_numbers))
]]--

sum_numbers={}
for kk=1,max_noncomposite_sum do
   sum_numbers[kk]=kk
end

print("is_abundant_sum_of_two(28123,abundant_numbers)",is_abundant_sum_of_two(28123,abundant_numbers))


print("#sum_numbers:",#sum_numbers)

for kk=1,#sum_numbers do
   if 1 == is_abundant_sum_of_two(sum_numbers[kk],abundant_numbers)
   then
      sum_numbers[kk] = 0
   end
end


print("Sums of Abundant_numbers are 0 in this array:")
useful.print_array(sum_numbers)


sum=useful.sumtable(sum_numbers)
print("Answer:",sum)

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

max_noncomposite_sum=28123
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
--]]


sum_numbers={}
for kk=1,max_noncomposite_sum do
   sum_numbers[kk]=kk
end

for jj,kk in ipairs(sum_numbers) do
   if is_abundant(kk,abundant_numbers) then
      sum_numbers[jj]=0
   end   
end
print("Abundant_numbers are 0 in this array:")
useful.print_array(sum_numbers)

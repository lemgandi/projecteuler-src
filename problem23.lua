--
-- Solve problem 23
--
require "useful"

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
useful.print_array(abundant_numbers)
print("Abundant numbers below " .. max_noncomposite_sum .. ":" .. #abundant_numbers .. "")


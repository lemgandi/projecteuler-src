--
-- Find sum of all pairs of amicable numbers below limit
--

require "useful"
require "table"

function find_factors(n)
   local retVal={}
   local my_sqrt_floor=math.floor(math.sqrt(n))
   local this_factor=1
   while this_factor <= my_sqrt_floor do
      if 0 == n % this_factor then
         retVal[#retVal+1]=this_factor
         retVal[#retVal+1]=n / this_factor
         -- Handle special case of a perfect square and 1
         if retVal[#retVal - 1] == retVal[#retVal] or retVal[#retVal] == n
         then
            retVal[#retVal]=nil
         end
      end
      this_factor = this_factor + 1
   end
   return retVal
end


function find_sum_of_factors(n)
   local factor_table=find_factors(n)
   local retVal=0
   for kk=1,#factor_table do
      retVal = retVal + factor_table[kk]
   end
   return retVal
end

function order_sort(a,b)
   local retVal=false
   if a[2] < b[2] then
      retVal=true
   end
   return retVal
end

-- Main Line

limit=10000
local numTable = {}
for kk=1,limit do 
   ll=find_sum_of_factors(kk)
   numTable[kk]=ll
end

amicable_table={}
sum=0
for kk=1,limit do
   ll=numTable[kk]
   if ll < #numTable and ll < kk and numTable[ll] == kk then
      sum = sum + ll + kk
      print("Amicable: " .. kk .. " and " .. ll .. "")
   end
end
print("Sum: " .. sum .. "")

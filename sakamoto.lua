-- Sakamotos algorithm in lua
require "math"


function sakamoto(y,m,d)

   month_table={ 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4 }
   if( m < 3 ) then
      y=y-1
   end
   retVal=(y+math.floor(y/4)-math.floor(y/100)+math.floor(y/400)+month_table[m]+d)
   return retVal % 7
end

sunday_count=0

for kk=1901,2000 do
  for mm=1,12 do
      if (0 == sakamoto(kk,mm,1)) then
        sunday_count=sunday_count+1
       print("Sunday month:" .. mm .. "/" .. kk )
     end
  end
end

print("Number of Sunday Months: " .. sunday_count)

-- print("3 1902:" .. sakamoto(1902,3,1))
require "math"
require "useful"

sum=0
for kk = 3,2000000,2 do
   if useful.is_prime(kk) then
      sum = sum + kk
   end
end
print(sum+2)

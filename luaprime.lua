require "math"

the_composite=600851475143 
top_bound=math.ceil(math.sqrt(the_composite))

for kk=1,top_bound do
   if the_composite % kk == 0 and kk % 2 ~= 0 and kk % 3 ~= 0 then
      print(kk)
   end        
end

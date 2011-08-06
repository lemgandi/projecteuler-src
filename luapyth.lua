require "math"

function generate_pyth_triplet(p,q)
   a=(2*p)*(p+(2*q)-1)
   b=((2*q)-1)*((2*p)+((2*q)-1))
   c=(p+((2*q)-1))^2+(p^2)
   return a,b,c
end

for kk=1,1000 do
  for jj=kk,1,-1 do
     a,b,c=generate_pyth_triplet(jj,kk)
     if (a+b+c == 1000) then
        print("The triplet: "..a.." "..b.." "..c.." "..(a+b+c))
        print("The product: ".. a*b*c)
        break
     end
  end
end

function is_natural(kk)
   retVal=nil
   if math.ceil(kk) == math.floor(kk) then
      retVal=1
   end
   return retVal
end

-- a=43
-- asq=a^2
-- for kk=1,1000 do
--    if is_natural(math.sqrt(asq+kk^2)) then
--       print(a.." "..kk.." "..math.sqrt(asq+kk^2))
--    end
-- end
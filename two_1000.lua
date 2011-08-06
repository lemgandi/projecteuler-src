require "useful"
require "bignum"
require "math"

-- Main Line

answer=bignum.new(2)
mul=bignum.new(2)
limit=1000
for kk=1,limit-1 do
   answer=answer * mul
end
ans_str=answer:tostring()
print("2^"..limit.." = "..ans_str)
sum=0
for fid in string.gfind(ans_str,"%d") do 
   sum=sum+fid
end
print("Sum of digits = "..sum)

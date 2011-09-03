--[[
 Solve problem 22 on projecteuler.net
--]]
require "math"
require "string"
require "table"
require "bignum"

function compute_name_score(fname,rank)
   atoz="ABCDEFGHIJKLMNOPQRSTUVWXYZ"

   local namesum=0
   local num=0

   for jj in string.gmatch(fname,"%u") do
      num=string.find(atoz,jj)
      namesum=namesum + num
   end
   retVal=namesum * rank
   return retVal
end

--
-- Main Line
--

io.input("./names.txt")
namestr=io.read("*all")
nametable={}
nametable_i=1
for kk in string.gmatch(namestr,'"[A-Z]+"',"" ) do
   nametable[nametable_i]=string.gsub(kk,'",$',"")
   nametable[nametable_i]=string.gsub(nametable[nametable_i],'"',"")
   nametable_i = nametable_i + 1
end

table.sort(nametable)

total=bignum.new(0)
for ll,kk in ipairs(nametable)
do 
   total = total + compute_name_score(kk,ll)
   print(ll,kk)
end
print("Total: " .. total .. "")

--[[
for kk=1,#nametable do
   print(nametable[kk])
end
--]]



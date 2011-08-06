require "string"

function five_greatest_prod(str)
   local biggest=0
   for poo in string.gfind(str,"%d%d%d%d%d") do
      sum=1
      for fid in string.gfind(poo,"%d") do
         sum=sum*fid
      end
      if sum > biggest then
         biggest=sum
      end
   end
   return biggest
end


-- Main Line
file_str=io.read("*all")
num_str=string.gsub(file_str,"%c","")
biggest=five_greatest_prod(num_str)
num_str=string.sub(num_str,2)
while # num_str > 0 do
   maybe_bigger=five_greatest_prod(num_str)
   if maybe_bigger > biggest then
      biggest=maybe_bigger
   end
   num_str=string.sub(num_str,2)
   print("Len of num_str now: " .. # num_str)
end

print("Biggest: "..biggest)


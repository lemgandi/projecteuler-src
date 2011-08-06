

function collatz(n)
   local inc=n
   local numsteps=0
   while inc ~= 1 do
      if ( inc % 2 ) == 0 then
         inc = inc / 2
      else
         inc = (inc * 3) + 1
      end
      numsteps = numsteps + 1
   end
   return numsteps
end

-- Main Line
largest_ns=0
largest_kk=0
top=1000000

for kk=1,top do
   ns=collatz(kk)

   if largest_ns < ns then
      largest_kk=kk
      largest_ns=ns
   end
end

print("Under: "..top.." largest is ".. largest_kk .. " at ".. largest_ns)
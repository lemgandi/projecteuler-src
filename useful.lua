-- Useful routines for projecteuler
require "math"
useful={

-- Return the factorial of a number
fact = function(n)
   if n == 0 then
      return 1
   else
      return n * useful.fact(n-1)
   end
end,

-- Copy a table to another table (assignment just copies the reference)
copytable = function(from,to)
  for jj,kk in ipairs(from) do
     to[jj]=kk
  end
end,

-- Iterate over all items in an array in all possible groups of n
get_byn_iterator = function(t,n)
   current_beginning=1
   current_position=1

   return(function ()
      retVal={}
      if current_beginning == n then
         retVal=nil
      end
      if retVal then
         for kk=1,n do
            retVal[kk]=t[current_position+(kk-1)]
         end
         current_position = current_position + n
         num_left=( (#t) - current_position )
         if num_left < n-1 then
            current_beginning=current_beginning+1
            current_position=current_beginning        
         end
      end
      return retVal
   end)
end,

-- Print an array to the screen.
print_array = function(tb)
   for nn,mm in ipairs(tb) do
      print("Number: "..nn.." Value: ",mm,"Type: ",type(mm))      
   end
end,

-- Is a number a natural number?
is_natural = function(kk) 
   retVal=nil
   if kk > 0 then
      if math.ceil(kk) == math.floor(kk) then
         retVal=1
      end
   end
   return retVal
end,


-- Determine if a number is prime.
is_prime = function(number)
   my_sqrt=math.sqrt(number)
   local retVal=1
   for nn=2,my_sqrt do
     if 0 == number % nn then
        retVal=nil
        break
     end
   end
   return retVal
end,

  
}

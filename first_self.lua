require "table"

first={}
first.__index=first

function first.new(flag)

   local my_first={}
   
   setmetatable(my_first,first)
   my_first.flag=flag
 
   return my_first
end

function first.noself(o)
  print(o)
end

function first.withself(self,next)
   self.noself(next)
   print(self.flag)
end

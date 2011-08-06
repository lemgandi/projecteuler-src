#! /usr/bin/env lua

require "useful"
require "math"

last_natural=0
last_triangle=0
   
function triangle_iterator()
   last_natural = last_natural+1
   last_triangle=last_triangle+last_natural
   return last_triangle    
end

-- Main line

while not finished do
      trial=triangle_iterator()
      factor_count=0
      for kk=1,math.sqrt(trial) do
         if 0 == trial % kk then
           factor_count = factor_count + 2
         end
      end
      if factor_count > 499 then
         finished=1
         print("First triangle: "..trial.." Factors: "..factor_count)
      end
end

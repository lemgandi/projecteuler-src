--[[
   Find the first term in the fibonacci sequence to contain 1,000 digits
]]--

require "math"
require "useful"
require "bignum"
require "table"
require "io"

--
--  Main Line
--


fibtable={bignum.new(0),bignum.new(1)}
limit = bignum.new(1000)

counter=1
while fibtable[2]:len_digits() ~= limit
do
   counter = counter + 1
   n=fibtable[1]+fibtable[2]
   fibtable[1] = fibtable[2]
   fibtable[2]=n
--   print(fibtable[2],fibtable[2]:len_digits())
end

print(counter)

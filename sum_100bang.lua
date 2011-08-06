--
-- Calculate sum of digits of 100!
--
require "math"
require "useful"
require "bignum"

one_hundred=bignum.new("100")
one_hundred_bang=useful.fact(one_hundred)
print("100! = " .. one_hundred_bang)

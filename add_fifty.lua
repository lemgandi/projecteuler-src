require "useful"
require "bignum"
require "io"

-- Main Line

the_sum=bignum.new()

for line in io.lines() do
   new_bg=bignum.new(line)
   the_sum=the_sum+new_bg
end
the_sum:print()
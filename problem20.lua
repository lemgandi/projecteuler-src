require "bignum"


one_hundred=bignum.new(100)
one_hundred_fact=one_hundred:factorial()
print("One_hundred_fact: "  .. one_hundred_fact .. "")
sum_digits=one_hundred_fact:sum_digits()
print("Sum Digits: " .. sum_digits .. "")

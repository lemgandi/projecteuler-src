require "math"

function test_is_prime(number)
   my_sqrt=math.sqrt(number)
   local is_prime=1
   for nn=2,my_sqrt do
     if 0 == number % nn then
        is_prime=nil
        break
     end
   end
   return is_prime
end

-- Main Line starts here.

prime_table={}
primecount=1
prime_to_test=2
while primecount < 10007 do
   is_prime=test_is_prime(prime_to_test)
   if is_prime then
      prime_table[primecount]=prime_to_test
      primecount =  primecount+1
   end
   prime_to_test = prime_to_test+1
end

for jj,kk in ipairs(prime_table) do
   print("Prime number: " .. jj ..  " equals " .. kk)
end


     


-- 1 1 2 3 5 8 13 21 34

last=1
this=1
sum=0

function fib ()
  retval=last+this
  last=this
  this=retval
  return retval
end 


kk=fib()
while kk < 4000000
do
    if kk % 2 == 0
    then
        sum = sum+kk
    end
    kk=fib()
 end

print(sum)
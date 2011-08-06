squaresum=0
strtsum=0
for kk=1,100 do
   squaresum = squaresum+(kk*kk)
   strtsum=strtsum+kk
end
print("squaresum:"..squaresum.." Straight sum:"..strtsum)
strsumsq=strtsum*strtsum
print("Straight sum squared:"..strsumsq)
print("Difference:"..(strsumsq-squaresum))

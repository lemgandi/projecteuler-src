

for kk=20,9000000000,20
do
   nope=nil
   for jj=1,20 do
        if kk % jj ~= 0 then
           nope=1
           break
        end
   end
   if not nope then
      print(kk)
      break
   end
end
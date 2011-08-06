sum = 0
added = 0

for kk = 0,999 do
  added=0
  if (kk % 5) == 0 then
    sum = sum + kk
    added=1
  end
  if ( kk % 3) == 0 and added == 0 then
       sum = sum + kk
    end
end

print(sum)

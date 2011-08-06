require "math"
require "table"

palind_table = {}
for kk=999,100,-1 do
   for jj=999,100,-1 do
      ff=kk*jj
      ffstr=tostring(ff)
      if ffstr == ffstr:reverse() then
        table.insert(palind_table,ff)
      end
   end
end
table.sort(palind_table)
print(palind_table[#palind_table])


require "useful"
require "digits_english"
require "table"

-- Test digits to english
data_t={}
for kk=1,999 do
   table.insert(data_t,digits_english.parse_below_thousand(kk))
end
out_str=table.concat(data_t)
print(out_str)

require "io"
require "table"
require "useful"

-- 
-- Parse a text line full of 2-digit numbers.
--
function parse_line(theline)
	 retVal={}
	 kk = 1
	 for n in theline:gmatch("%d%d") do
	     retVal[kk]=n
	     kk = kk+1
	 end
	 return retVal
end

--
-- Sort routine to do a rev sort
--
function rev_comp(a,b)
   retval=false
   if ( a > b ) then
      retval=true
   end
   return retval
end


--
-- Find the nth biggest number in a row and return its
-- index number.
--
function find_nth_biggest_num_in_row(therow,n)
   sorted_value_table={}
   index_table={}
   useful.copytable(therow,sorted_value_table)
   table.sort(sorted_value_table,rev_comp)
   nth_row_value=sorted_value_table[n]
   row_index=1
   while row_index <= #therow do
      if ( therow[row_index] == nth_row_value ) then
         table.insert(index_table,row_index)
      end
      row_index=row_index+1
   end
   return index_table
end

--
-- Given a pair of tables and a number, find the nth biggest number 
-- in each row of  
-- the input table, then put it into the corresponding row and place of the 
-- output table.
--
function add_nth_num_to_out_table(input_tbl,output_tbl,n)
   for kk=1,#input_tbl
   do
      ind_t=find_nth_biggest_num_in_row(input_tbl[kk],n)
      for mm=1,#ind_t
      do
         output_tbl[kk][ind_t[mm]]=input_tbl[kk][ind_t[mm]]
      end
   end
   return 0
end

-- 
-- Print out table
--
function print_table(tbl)
   for jj=1,#tbl
   do
      print("Row: " .. jj .. " " .. table.concat(tbl[jj],","))
   end
end

-- Main Line

rownum=1
rowtable={}
for myline in io.lines() 
do
    table.insert(rowtable,parse_line(myline))
    rownum = rownum + 1
end

out_table={}
for tbl_row=1,15 
do
   my_table={}
   for inst=1,tbl_row
   do
      table.insert(my_table,0)
   end
   table.insert(out_table,my_table)
end

add_nth_num_to_out_table(rowtable,out_table,1)
add_nth_num_to_out_table(rowtable,out_table,2)
print_table(out_table)
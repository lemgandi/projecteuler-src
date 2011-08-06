require "useful"
require "io"


-- Iterate over all items in an array in all possible groups of n
function get_byn_iterator(t,n)
   current_beginning=1
   current_position=1

   return(function ()
      retVal={}
      if current_beginning == n then
         retVal=nil
      end
      if retVal then
         for kk=1,n do
            retVal[kk]=t[current_position+(kk-1)]
         end
         current_position = current_position + n
         num_left=( (# t) - current_position )
         if num_left < n-1 then
            current_beginning=current_beginning+1
            current_position=current_beginning        
         end
      end
      return retVal
   end)
end


--
-- Main Line
--

grid_table={}
grid_table_index=1

for line in io.lines() do
   grid_table[grid_table_index]={}
   lti=1
   for n in line:gmatch("%d%d") do
      grid_table[grid_table_index][lti]=n
      lti = lti+1
   end
   grid_table_index = grid_table_index+1
end

biggest_row_prod=0

for jj,kk in ipairs(grid_table) do
   row_allfour_iterator=get_byn_iterator(kk,4)
   for block in row_allfour_iterator do
      block_prod=block[1]*block[2]*block[3]*block[4]
      if block_prod > biggest_row_prod then
         biggest_row_prod=block_prod
      end
   end
end
print("biggest row prod: "..biggest_row_prod)
col_allfour_iterator=get_byn_iterator(grid_table,4)
col_max_prod=0
diag_max_prod=0
for block in col_allfour_iterator do   
   for jj=1,20 do 
      col_prod=block[1][jj]*block[2][jj]*block[3][jj]*block[4][jj]
      if(jj<16) then
              diag_prod=block[1][jj+1]*block[2][jj+2]*block[3][jj+3]*block[4][jj+4]
              if diag_max_prod < diag_prod then
                 diag_max_prod=diag_prod
              end
      end
      if (jj>5) then
         diag_prod=block[1][jj-1]*block[2][jj-2]*block[3][jj-3]*block[4][jj-4]
         if diag_max_prod < diag_prod then
            diag_max_prod=diag_prod
         end
      end
      if col_max_prod < col_prod then
         col_max_prod=col_prod
      end
   end
end
print("Biggest col sum: " .. col_max_prod)
print("Biggest diag sum: " .. diag_max_prod)





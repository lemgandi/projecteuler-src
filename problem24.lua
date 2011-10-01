--[[
Solve problem 24 with Pandita's Algorithm:

given array a with length n:
  Find largest kk such that a[kk] < a[kk+1] 
  Find largest ii such that a[kk] < a[ii]
  Swap a[kk] and a[ii]
  Reverse from a[kk+1] to a[n] inclusive
--]]

require "math"
require "useful"

--
-- Local function to print aa array.
--
function print_aa(a)
   local bstr=""
   for jj,nn in ipairs(a) do
      bstr=bstr .. nn .. ""
   end
   print(bstr)
end
--
-- Find the kk ( largest such that a[kk] < a[kk+1]) in an array )
-- Return nil if array is completely reversed (the end)
--
function find_largest_kk(a)
   retVal=nil
   for kk=1,#a
   do
      if a[kk+1] ~= nil then
         if a[kk] < a[kk+1] then
            retVal=kk
         end
      end
   end
   return retVal
end

--
-- Find the ii ( largest such that n < a[ii])
--
function find_largest_ii(a,n)
   retVal=nil
   for kk=1,#a
   do
      if a[kk] > n then
         retVal=kk
      end
   end
   return retVal
end

--
-- Given a table and an index, reverse the entries in the table
-- after the index (e.g. {1,2,3,4},2 returns {1,2,4,3} )
--
function rev_table_piece(a,n)
   local retVal={}
   local table_ctr=1

   while table_ctr < n
   do
      retVal[table_ctr]=a[table_ctr]
      table_ctr = table_ctr + 1
   end

   for nn=#a,n,-1
   do
      retVal[table_ctr]=a[nn]
      table_ctr = table_ctr + 1
   end

   return retVal
end

--
-- Given table and two indexes, swap entries in those indexes
--
function swap_pair(a,n,f)
   local middle=a[n]
   a[n]=a[f]
   a[f]=middle
end


--
-- Main Line
--
print("Before")
aa={0,1,2,3,4,5,6,7,8,9}

limit=1000000
print("Factorial 10:",useful.fact(10),"Limit:",limit)
print_aa(aa)
for kk=1,limit
do
   largest_k=find_largest_kk(aa)
   if nil == largest_k then
      print("Out before limit.")
      break
   end
   largest_ii=find_largest_ii(aa,aa[largest_k])
   swap_pair(aa,largest_k,largest_ii)
   aa = rev_table_piece(aa,largest_k+1)
end
print_aa(aa)
require "string"
require "math"
require "useful"
require "table"

-- Handle unlimited place arithmetic to to learn lua

-- create bignum namespace (okay, table)
bignum={}

-- Table for big number

bignum.my_bignum={}

-- Multiply a table by one digit (used in __mul)
function bignum.mul_by_one_digit(icand,ator)
   local answer_t={}
   local answer_t_index=1
   local carry=0
   local my_answer=0
   for jj,kk in ipairs(icand) do         
         answer_t[answer_t_index]=carry
         my_answer=kk * ator
         if my_answer >= 10 then
            carry=math.floor(my_answer / 10)
            my_answer=my_answer % 10
         else
            carry=0
         end
         answer_t[answer_t_index]=answer_t[answer_t_index]+my_answer
         if answer_t[answer_t_index] >= 10 then
            carry = carry + math.floor(answer_t[answer_t_index]/10)
            answer_t[answer_t_index]=answer_t[answer_t_index] % 10
         end
         answer_t_index = answer_t_index+1
   end
   if carry > 0 then
      if carry >= 10 then
         table.insert(answer_t,math.floor(carry / 10))
         table.insert(answer_t,carry % 10)      
      else
         table.insert(answer_t,carry)
      end   
   end
   return answer_t
end

--
-- Which of a pair of bignum tables represents the lesser number?
--
function bignum.lessorequal_table(table1,table2)
   t1,t2=bignum.equalize_tables(table1,table2)
   retVal=0
   for kk=1,#t1 do
      if t1[kk] > t2[kk] then
         retVal=1
      end
      if t1[kk] < t2[kk] then
         retVal=-1
      end
      if retVal ~= 0 then
         break
      end
   end
   return retVal
end

-- Subtract one bignum table from another.
function bignum.sub_table(table1,table2)

   neg_flag=false

   -- Always subtract abs lesser from abs greater. 
   -- Set negative if necessary.
   if bignum.lessorequal_table(table1,table2) < 0 
   then
      t2,t1=bignum.equalize_tables(table1,table2)
      neg_flag=true
   else
      t1,t2=bignum.equalize_tables(table1,table2)
   end

   answer_t={}
   carry=false
   for kk=1,#t1 do
      if carry then
         t1[kk] = t1[kk] - 1
         carry=false
      end
      answer=t1[kk] - t2[kk]
      if answer < 0 then
         carry=true
         answer=(t1[kk] + 10 ) - t2[kk]         
      end
      answer_t[kk]=answer
   end
   return answer_t,neg_flag
end

--
-- Make sure a pair of number tables are of equal length.
-- Pad with 0 as necessary.
--
function bignum.equalize_tables(t1,t2)
   retval1={}
   retval2={}
   useful.copytable(t1,retval1)
   useful.copytable(t2,retval2)
   len_diff= #retval1 - #retval2
   if len_diff < 0 then
      for kk=#retval1+1,#retval2 do
         retval1[kk]=0
      end
   end
   if len_diff > 0 then
      for kk=#retval2+1,#retval1 do
         retval2[kk]=0
      end
   end
   return retval1,retval2
end

-- Add a pair of bignum tables to produce a table of the sum.
-- Used in __add, __mul routines.
function bignum.add_table(table1,table2)
   my_add_t,other_add_t=bignum.equalize_tables(table1,table2)
   answer_t={}
   remainder=0
   for kk=1,#my_add_t do      
      answer=my_add_t[kk]+other_add_t[kk]
      if remainder > 0 then
         answer = answer + remainder
         remainder=0
      end
      if(answer >= 10) then
         remainder=1
         answer=answer - 10
      end
      answer_t[kk]=answer
   end

   if remainder > 0 then
      answer_t[#answer_t+1]=1
   end
   return answer_t
end

-- Subtract a pair of bignums..
function bignum.__sub(self,other_bignum)

   if type(other_bignum) ~= "table" then
      other_bignum=bignum.new(other_bignum)
   end

   answer_t,neg_flag=self.sub_table(self.my_num,other_bignum.my_num)   

   retVal=bignum.new(answer_t)
   retVal.neg_flag=neg_flag
   return retVal
end

-- Multiply a pair of bignums
function bignum.__mul(self,other_bignum)

   if (type(other_bignum) ~= "table") then
      other_bignum=bignum.new(other_bignum)
   end

   multiplicand={}
   useful.copytable(self.my_num,multiplicand)
   multiplicator={}
   useful.copytable(other_bignum.my_num,multiplicator)
   answer_accumulator={}
   for jj,kk in ipairs(multiplicator) do
      intermediate=self.mul_by_one_digit(multiplicand,kk)
      if jj == 1 then
         useful.copytable(intermediate,answer_accumulator)
      else
         for place=1,jj-1 do
            table.insert(intermediate,1,0)
         end
         answer_accumulator=self.add_table(answer_accumulator,intermediate)
      end
   end
   retVal=bignum.new(answer_accumulator)
   return retVal   
end

-- Add a pair of bignums
function bignum.__add(self,other_bignum)

-- Allow bignum + int, et cetera.
   if type(other_bignum) ~= "table" then
      other_bignum=bignum.new(other_bignum)
   end

   answer_t=self.add_table(self.my_num,other_bignum.my_num)
   retVal=bignum.new(answer_t)
   return retVal
end

-- Set big number table directly
function bignum.set_directly(self,t)
   self.my_num=t
end

-- Print a bignum to screen
function bignum.print(self)
  print(self:tostring())
end

-- Convert bignum to a string
function bignum.tostring(self)
   s=""
   mytable={}
   useful.copytable(self.my_num,mytable)
   for kk=#mytable,1,-1 do
      if mytable[kk] == 0 then
         mytable[kk]=nil
      end
   end
   for kk,jj in ipairs(mytable) do
      s=s .. jj
   end
   if self.neg_flag then
      s=s .. "-"
   end
   s=s:reverse()
   return s
end

--
-- Add all the digits in bignum together. 
--
function bignum.sum_digits(self)
   retval=bignum.new(0)
   for ll,kk in ipairs(self.my_num) do
      retval = retval + kk
   end
   return retval
end

-- all bignums inherit from bignum. Make sure that they get their
-- method names by setting the __index method to bignum here.
bignum.__index = bignum

-- create a bignum from a string or table
function bignum.new(t)

   local my_bignum={}


   setmetatable(my_bignum,bignum)

   -- Make sure that each individual bignum created has its own space for
   -- big numbers.
   my_bignum.my_num={}
   my_bignum.neg_flag=false

   local fromstr=function(s)
        s=s:reverse()
        local idx=1
        for n in s:gmatch("%d") do
           my_bignum.my_num[idx]=n
           idx=idx+1
        end
   end

   local fromnum=function(n)
      local my_str=n..""
      fromstr(my_str)
   end

   local fromtable=function(t)
      my_bignum.my_num=t
   end

   local fromnil=function(t)
      my_bignum.my_num[0]=0
   end

   local type_fn_table={}
   type_fn_table["string"]=fromstr
   type_fn_table["number"]=fromnum
   type_fn_table["table"]=fromtable
   type_fn_table["nil"]=fromnil

   type_fn_table[type(t)](t)

   return my_bignum

end

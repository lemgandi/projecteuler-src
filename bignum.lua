require "string"
require "math"
require "useful"
require "table"

-- Handle unlimited place arithmetic to to learn lua

-- create bignum namespace (okay, table)
bignum={}

-- Table for big number

bignum.my_bignum={}


-- Convert bignum to a string
function bignum.tostring(self)
   local s=""
   for kk,jj in ipairs(self.my_num) do
      s=s .. string.format("%d",jj)
   end
   if self.neg_flag then
      s=s .. "-"
   end
   s=s:reverse()
   return s
end

bignum.__tostring = bignum.tostring

--
-- Multiply a table by one digit (used in __mul)
--
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
-- Which of a pair of bignum tables represents the lesser
-- absolute value?
--
function bignum.abs_lessorequal_table(table1,table2)

   t1,t2=bignum.equalize_tables(table1,table2)

   local abs_retval=0
   for kk=#t1,1,-1 do
      if t1[kk] > t2[kk] then
         abs_retval=1
      end
      if t1[kk] < t2[kk] then
         abs_retval=-1
      end
      if abs_retval ~= 0 then
         break
      end
   end
   return abs_retval
end
--
-- Which of a pair of bignum tables represents the lesser number?
--
function bignum.lessorequal_table(table1,negflag1,table2,negflag2)
   local retVal=0 -- Assume equality
   local status=true

   -- (-1) always < (1)
   if negflag1 and not negflag2 then 
      retVal=-1
      status=false
   end
   -- (1) always > (-1)
   if not negflag1 and negflag2 then
      retVal=1
      status=false
   end
   if status == true then
      abs_equality=bignum.abs_lessorequal_table(table1,table2)
      -- if both numbers are positive or they are equal, abs equality 
      -- equals equality.
      retVal=abs_equality
      -- If both numbers are negative and unequal, equality relation is 
      -- reversed.
      -- We have already eliminated unequal negflags above.
      if negflag1 and abs_equality ~= 0 then
         retVal = -abs_equality
      end   
   end
   return retVal
end

--
-- Is this object equal to another bignum?
--
function bignum.__eq(self,other)
   local retVal=false
   if 0 == bignum.lessorequal_table(self.my_num,self.neg_flag,other.my_num,other.neg_flag) then
      retVal=true
   end
   return retVal
end

--
-- Is this object less than another bignum?
--
function bignum.__lt(self,other)
   local retVal=false
   if -1 == bignum.lessorequal_table(self.my_num,self.neg_flag,other.my_num,other.neg_flag) then
      retVal=true
   end
   return retVal
end

function bignum.__gt(self,other)
   local retVal=false
   if 1 == bignum.lessorequal_table(self.my_num,self.neg_flag,other.my_num,other.neg_flag) then
      retVal=true
   end
   return retVal
end

function bignum.__le(self,other)
   local retVal=true
   if 1 == bignum.lessorequal_table(self.my_num,self.neg_flag,other.my_num,other.neg_flag) then
      retVal=false
   end
   return retVal
end

function bignum.__ge(self,other)
   local retVal=true
   if -1 == bignum.lessorequal_table(self.my_num,self.neg_flag,other.my_num,other.neg_flag) then
      retVal=false
   end
   return retVal
end

-- Subtract one bignum table from another.
function bignum.sub_table(table1,table2)

   local neg_flag=false

   -- Always subtract abs lesser from abs greater. 
   -- Set negative if necessary.
   if bignum.abs_lessorequal_table(table1,table2) < 0 
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
   local retval1={}
   local retval2={}
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
   local my_add_t={}
   local other_add_t={}
   my_add_t,other_add_t=bignum.equalize_tables(table1,table2)

   local answer_t={}
   local remainder=0
   local answer=0
   local remainder=0

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

function bignum.polymorph(self,other)

   local retVal=other
   if type(other) ~= "table" then
      retVal=bignum.new(other)
      if other and other < 0 then
         retVal.neg_flag=true
      end
   end
   if getmetatable(retVal) ~= getmetatable(self) then
      retVal=bignum.new(other)
   end
   return retVal
end

--
-- Subtract a pair of bignums.
--
function bignum.__sub(self,other_bignum)
   local other_bignum=self:polymorph(other_bignum)
   local neg_flag
   local answer_t

   answer_t,neg_flag=self.sub_table(self.my_num,other_bignum.my_num)   
   
   kk=#answer_t
   while answer_t[kk] == 0 do
      answer_t[kk]=nil
      kk=kk-1
   end   
   local retVal=bignum.new(answer_t)
   retVal.neg_flag=neg_flag
   return retVal
end

--
-- Get bignum modulo. 
--
function bignum.__mod(self,o)

   local other=self:polymorph(o)

   assert(other ~= bignum.new(0),"Divide by zero")

   -- This gets assigned a value. 
   local retVal=bignum.new(self.my_num)

    local intermediate_value=bignum.new(self.my_num)
    while intermediate_value > bignum.zero do
      retVal=intermediate_value;
      -- Handle special case where modulo == 0
      if intermediate_value == other then
         retVal=bignum.new(0)
      end
      intermediate_value = intermediate_value - other      
   end
   return retVal
end

--
-- Divide one bignum by another.
--
function bignum.__div(self,o)

   local other=self:polymorph(o)

   assert(other ~= bignum.new(0),"Divide by zero")

   -- This gets assigned a value. 
   local retVal=bignum.new(0)
    local intermediate_value=bignum.new(self.my_num)
    while intermediate_value > bignum.zero do
      intermediate_value = intermediate_value - other
      if ( intermediate_value >= bignum.zero) then
         retVal = retVal + 1
      end
   end
   return retVal
end

--
-- Multiply a pair of bignums
--
function bignum.__mul(self,other_bignum)

   local other_bignum=self:polymorph(other_bignum)

   local multiplicand={}
   useful.copytable(self.my_num,multiplicand)
   local multiplicator={}
   useful.copytable(other_bignum.my_num,multiplicator)
   local answer_accumulator={}
   local intermediate={}

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
   local retVal=bignum.new(answer_accumulator)
   if (multiplicand.neg_flag and not self.neg_flag) or (self.neg_flag and not muliplicand.neg_flag) then
      retVal.neg_flag=true
   end
   return retVal   
end

-- Add a pair of bignums
function bignum.__add(self,o_bignum)

   local other_bignum=self:polymorph(o_bignum)

   answer_t=self.add_table(self.my_num,other_bignum.my_num)
   local retVal=bignum.new(answer_t)
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
--
-- Raise bignum to a power.
--
function bignum.__pow(self,o)

   local other=self:polymorph(o)

   local retVal=bignum.new(self.my_num)

   while other > bignum.one do
      other = other - 1   
      retVal=retVal * self
   end
   return retVal
end

function bignum.__concat(self,other)
   return (self:__tostring() .. other )
end


--
-- Add all the digits in bignum together. 
--
function bignum.sum_digits(self)
   local retval=bignum.new(0)
   for ll,kk in ipairs(self.my_num) do
      retval = retval + math.floor(kk)
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
        if s[0] == '-' then
           my_bignum.neg_flag=true
        end
        s=s:reverse()
        local idx=1
        for n in s:gmatch("%d") do
           my_bignum.my_num[idx]=n+0
           idx=idx+1
        end
   end

   local fromnum=function(n)
      if n < 0 then
         my_bignum.neg_flag=true
      end
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

-- 
-- Convenience for square root
--
function bignum.sqrt(self)
   return self:root(2)
end
--
-- Find nth root of bignum
--
function bignum.root(self,o)
   local other=self:polymorph(o)
   local testval=bignum.new(1)
   local topval=bignum.new(1)
   local bottomval=nil

   while testval < self do
      topval=topval+1
      testval = topval ^ o
   end

   if testval == self then
      bottomval=topval
   else
      bottomval=topval - 1
   end

   return topval,bottomval   
end

function bignum.recursive_fact(n)
   if n == bignum.zero then
      return 1
   else
      return  n * bignum.recursive_fact(n-1)
   end
end

--
-- Recursive function to compute my factorial.
-- ( should be a local but recursion apparently prevents this)
-- 
function bignum.recursive_fact(n)
   if bignum.zero == n then
      return 1
   else
      return n * bignum.recursive_fact(n-1)
   end
end

-- 
-- Factorial for bignums
--
function bignum.factorial(self)
   local retVal=bignum.new(self.my_num)
   return self.recursive_fact(retVal)
end

--
-- How many digits does bignum contain?
--
function bignum.len_digits(self)
   bignumStr=self:tostring()
   retVal=bignumStr:len()
   retVal=bignum.new(retVal)
   return retVal
end

--
-- Find all factors of given number
--
function bignum.find_factors(self)
   local retVal={}
   local my_sqrt_ceil,my_sqrt_floor = self:sqrt()
   local this_factor=bignum.new(1)
   while this_factor <= my_sqrt_floor do
      if bignum.zero == self % this_factor then
         retVal[#retVal+1]=this_factor
         retVal[#retVal+1]=self / this_factor
         -- Handle special case of a perfect square and 1
         if retVal[#retVal - 1] == retVal[#retVal] or retVal[#retVal] == self
         then
            retVal[#retVal]=nil
         end
      end
      this_factor = this_factor + 1
   end
   return retVal
end

-- 
-- Force constants to be constant ( does not seem to workee )
function bignum.__newindex(t,k,v)
--   print("Set bignum." .. k)
   assert(k ~= "zero","Attempt to set read-only \"zero\" value")
   assert(k ~= "one", "Attempt to set read-only \"one\" value")
   rawset(t,k,v)      
end

-- Useful Constants ( should be read-only)
bignum["zero"]=bignum.new(0)
bignum["one"]=bignum.new(1)
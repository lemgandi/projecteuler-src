require "string"
require "math"
require "useful"

-- Convert numbers to english to learn lua

-- Create object namespace

digits_english={}

digits_english.digits = {"one","two","three","four","five","six","seven","eight","nine"}

digits_english.ten_twenty={"eleven","twelve","thirteen","fourteen","fifteen","sixteen","seventeen","eighteen","nineteen" }

digits_english.tens={"ten","twenty","thirty","forty","fifty","sixty","seventy","eighty","ninety" }

digits_english.powers={"hundred","thousand","million","billion","trillion","quadrillion","quintillion","sextillion","septillion","heptillion","octillion","nonillion","decillion","undecillion","duodecillion","tredecillion","quattuordecillion","quindecillion","sexdecillion","septendecillion","octodecillion","novemdecillion","vigintillion","centillion"}

function digits_english.parse_two(number)
   retVal=nil

   if number > 10 and number < 20 then
      retVal=digits_english.ten_twenty[number % 10]
   end
   if number == 10 then
      retVal=digits_english.tens[1]
   end
   if number < 10 then
      if number == 0 then
         retVal=""
      else
         retVal=digits_english.digits[number]
      end
   end
   if number >= 20 then
      local tens_place = math.floor(number / 10)
      local ones_place = number % 10
      retVal=digits_english.tens[tens_place]
      if ones_place > 0 then
         retVal=retVal .." ".. digits_english.digits[ones_place]
      end
   end
   return retVal
end

function digits_english.parse_three(number)
   local hundreds_place=math.floor(number / 100)
   lt_hundred = number % 100
   if lt_hundred > 0 then
      inter_str="and "
   else
      inter_str=""
   end

   retVal=digits_english.digits[hundreds_place] .. " hundred ".. inter_str .. digits_english.parse_two(lt_hundred)
   return retVal
end

function digits_english.parse_below_thousand(number)
  if number < 100 then
     retVal=digits_english.parse_two(number)
  else
     retVal=digits_english.parse_three(number)
  end
  return retVal
end






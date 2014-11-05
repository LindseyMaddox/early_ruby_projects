#From an algorithmic standpoint, checking if a number is prime can be 
#done by checking all numbers up to and including (rounding down to previous integer) 
#said number's square root.
#Math = If a prime factor exists that is GREATER than the square root of the number,
#then there must be one LESS than the square root, so there is no reason to check 
#above the square root.

#This doesn't make much difference at the lower end of the spectrum, but when you
#get to higher numbers, it's quite clear why this would be faster
#for 169, check up to 13 instead of my original up to 167. It is both having to check
#whether something is divisible and institute the next iteration (if not divisible)


print "What number would you like to check?  "
number = gets.chomp.to_i

i = 1

x = Math.sqrt(number)

until i >= x do 
  i += 1  
    if number % i == 0
      puts "Your number is divisible by #{i}, so it's not a prime number."
      break
     elsif i < x
       next
    else 
      puts "Your number isn't divisible by anything, so it's a prime number."
    end   
 end
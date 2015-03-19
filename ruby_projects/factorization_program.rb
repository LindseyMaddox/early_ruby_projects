#Given an integer <= 100, return an array of its factors.

puts "What number do you want to check?  "
number = gets.chomp.to_i


def factorization(number)
	
	distinct_factors = getting_distinct_factors(number)

	puts "The factors for #{number} are #{distinct_factors.inspect}" 

	even_factor_check(number) if distinct_factors.include?(2)

	odd_factor_check(number)

	factors = odd_factor_check(number)

	puts "which factorizes into #{factors.inspect}"
	
end

def getting_distinct_factors(number)
distinct_factors = []
#distinct_factors meaning each factor only once
						
	for i in 2..number 
		factor_square = Math.sqrt(i)
		divisor_check = 1
			while divisor_check < factor_square
				divisor_check += 1
					if i % divisor_check == 0 && i != divisor_check #have to account for 2 & 3
						break
					elsif i % divisor_check != 0 && factor_square > divisor_check 
						next
					elsif i % divisor_check != 0 && factor_square <= divisor_check && number % i != 0
						break 
					elsif i % divisor_check == 0 && i == divisor_check && number % i != 0 && number != 2 && number != 3
						break
					else
						distinct_factors.push(i) 
					end
			end
	end

	distinct_factors

end


def even_factor_check(number) 
	factors = []
	#factors includes each factor based on how many instances of the factor make up your number's factorization.

	even_index = 0

	#we already know 2 is a factor, so we can put the push outside of the loop.
	factors.push(2)

	while number > 2
		number /= 2
		if number % 2 == 0 && number != 2
			even_index += 1
		elsif number % 2 == 0 && number == 2
			#if we get all the way down to 2, then we'd have to start with 2*2.
			even_index += 1
			factors.fill(2,factors.size, (even_index))
			break
		else
			factors.fill(2,factors.size, (even_index))
			break
		end
	end

	factors
end

def odd_factor_check(number)
	distinct_factors = getting_distinct_factors(number)
	if distinct_factors.include?(2)
		factors = even_factor_check(number)
	else
		factors = []
	end

	odd_index = 0
	#o is odd number. 

	for o in 1..number
		o += 2
		if distinct_factors.include?(o)
			while number >= o
				number /= o
				if number % o == 0
					odd_index += 1
					factors.push(o) unless factors.include?(o)
				elsif factors.include?(o)
					factors.fill(o,factors.size, (odd_index))
					break
				else
					factors.push(o) 
					break
				end
			end
		end
	end

	factors
end

factorization(number)

class Game
	def initialize
			@code = code = [] 
				4.times do 
					code << rand(6)
				end 
				return code 
		end
			
		attr_reader :code
		 

		
		def prompt_player
			puts "Enter 4 numbers between and including 0 - 5 with each digit seperated by a space "
		end

		def player_guess
			gets.chomp.split().map{|s| s.to_i}
		end

		def play
			12.times do
				prompt_player
				if win?(hint(player_guess))
					p "Congratulations! You've won."
					break
				end
			end
		end

		def matching_arrays?(array_1, array_2, index)
			array_1[index] == array_2[index]
		end

		def hash_count(array)
			array.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }
		end

		def delete_item(array, x)
			array.delete_at(array.index(x) || array.length)
		end

		def stringify(array)
			array.join(",").to_s
		end
	

		def hint(guess)
			code_hash = hash_count(code)
			guess_hash = hash_count(guess)
			total = 0
			result=[]
      		guess.each_with_index { |char,index|
          		if code.include?(char)
              		if matching_arrays?(code, guess, index)
                  		result << "R"
              		else
                  		result << "W"
                  		total = guess_hash[char] - code_hash[char]
              		end
         		 end
 			 }
 		total.times do delete_item(result, "W") end	 
      	p stringify(result)
		end

		def win?(guess)
			guess == "R,R,R,R"
		end
end

gigi = Game.new
p gigi.code
gigi.play








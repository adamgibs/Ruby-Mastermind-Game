class PlayerGuessGame
		def initialize
			@code = [rand(6), rand(6), rand(6), rand(6)]
		end

		attr_reader :code

		def prompt_player
			puts "To guess the computer's code, enter 4 numbers between and including 0 - 5 with each digit seperated by a space "
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


class ComputerGuessGame

def player_code 
  gets.chomp.split().map{|s| s.to_i}
end

def computer_guess
  [rand(6), rand(6), rand(6), rand(6)] 
end
       
def player_hint
  gets.chomp 
end


def keepers(array1, array2)
  array1.each_with_index do |x,i|
    if array1[i] == array2[i]
      array1[i] = array1[i]
    else
      array1[i] = rand(6)
    end
  end
end

def play
  p "To make your code, choose four numbers between and including 0 - 5. Seperate each with a space."
  pc = player_code
  cg = computer_guess
  12.times do
    p keepers(cg, pc)
    player_hint
    if cg == pc
      p "The computer has figured out your code!"
      break
    end
  end
end

end


class ChooseGame

	def start_game(p_guess, c_guess)
		welcome_player
		x = player_choice
		if x == 1
			p_guess.play
		elsif x == 2
			c_guess.play
		else
			"Please enter either 1 or 2"
		end
	end

	private

	def welcome_player
		p "Mastermind is a game with two players."
		p "One player chooses a code and the other tries to guess it."
		p "In this version, the code is four characters long and is made up of the numbers 0 - 5."
		p "The game lasts either twelve turns or until the code is broken."
		p "Each turn consists of a guess provided by the Code Breaker followed by a hint by the Code Maker."
		p "The hint consists of an R's and W's."
		p "The R's mean that one of your numbers is in the code and is in the same position as your number."
		p "The W's mean that one of your numbers is in the code, but it is in a different position."
		p "The game is over when four R's are returned by the Code Maker"
		p "Let's begin!"
		p "If you would like to be the Code Breaker, type 1. If you would like to be the Code Maker, type 2"
	end

	def player_choice
		gets.chomp.to_i
	end
end

gigi = ChooseGame.new

gigi.start_game(PlayerGuessGame.new, ComputerGuessGame.new)

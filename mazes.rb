class Maze

	def initialize(x, y)
		@width = x
		@height = y
		@maze_string
		@maze_array = [][]
		@maze_string_split
	end


	def load x
		@maze_string = x
		@maze_string_split = x.chars.to_a
		string_counter = 0
		y=@height
		x=@width

		(0..(y*2+1)).each do |n|
			if @maze_string_split[counter] != 1
				puts "Error in given string"
			else
				@maze_array[n] = @maze_string_split[counter]
				counter++
			end
			(0..(x*2)).each do |m|
				if n==0 || n==(y*2+1) || m==(x*2)
					if @maze_string_split[counter] != 1
						puts "Error in given string"
					else
						@maze_array[n][m] = @maze_string_split[counter]
						counter++
					end
				else
					@maze_array[n][m] = @maze_string_split[counter]
					counter++
				end
			end
		end
	end

	def display
		level = 1
		type = 1
		ch1 = '+'
		ch2 = '-'
		ch3 = '|'
		@maze_array.each do |y|
			if level == 1
				level = 0
			elsif level == 0
				level = 1
			end
			y.each do |x|
				if level = 0
					if x == 1 && type == 0
						print ch1
						type = 1
					elsif x ==1 && type == 1
						print ch2
						type = 0
					elsif x == 0 && type == 0
						print ' '
						type = 1
					elsif x == 0 && type ==1
						print ' '
						type = 0
					end
				elsif level == 1
					if x == 1
						print ch3
					elsif x==0
						print " "
					end
				end
			end
		end

					

	end

	def solve(x1, y1, x2, y2)

	end

	def trace(x1, y1, x2, y2)

	end

	def redesign

	end

end

class Cell

	def initialize(x, y) 
		@x = x
		@y = y
	end

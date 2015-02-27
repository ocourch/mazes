class Maze

	def initialize(x, y)
		@width = x
		@height = y
		@maze_string
		@maze_array = [][]
		@maze_string_split
		@currCell
	end


	def load x
		@maze_string = x
		@maze_string_split = x.chars.to_a
		string_counter = 0
		y=@height
		x=@width

		(0..(y*2+1)).each do |n|
			if @maze_string_split[counter] != 1
				puts "Error in given string, wall expected"
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
		@currCell = Cell.new(0, 0)
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
				if level == 0
					if x == 1
						print ch3
					elsif x == 0
						print " "
					end

				elsif level = 1
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
				end				
			end
		end
	end

	def solve(x1, y1, x2, y2)
		if x1 == x2 && y1 == y2
			return true
		end
		S = Hash.new
		(0...@width).each do |w|
			(0...@height).each do |h|
				S.store(wh, Cell.new(w,h))
			end
		end
		C = S[xy]
		C.visited = true
		Q = Queue.new
		Q.enq(C)
		path = false
		while Q.empty==false do
			temp = Q.pop
			if temp.x == x2 && temp.y == y2
				path = true
				break
			end

			if temp.up == true
				checker = S[temp.x, temp.y-1]
				if checker.visited == false
					checker.visited = true
					Q.enq(checker)
				end
			end
			if temp.down == true
				checker = S[temp.x, temp.y+1]
				if checker.visited == false
					checker.visited = true
					Q.enq(checker)
				end
			end
			if temp.left == true
				checker = S[temp.x-1, temp.y]
				if checker.visited == false
					checker.visited = true
					Q.enq(checker)
				end
			end
			if temp.right == true
				checker = S[temp.x+1, temp.y]
				if checker.visited == false
					checker.visited = true
					Q.enq(checker)
				end
			end
		end
		return path
	end


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
		@array_x = x+x
		@array_y = 2*x+1
		@up = findup
		@down = finddown
		@left = findleft
		@right = findright
		@visited = false		
		
	end

	attr_accessor :visited
	attr_reader :up
	attr_reader :down
	attr_reader :left
	attr_reader :right
	attr_reader :x
	attr_reader :y
	
	def findup
		if @y == 0
			return false
		else
			return !(@maze_array[@array_y-1][@array_x] == 1)
		end
	end

	def finddown
		if @y == @height
			return false
		else
			return !(@maze_array[@array_y+1][@array_x] == 1)
		end
	end

	def findleft
		if @x == 0
			return false
		else
			return !(@maze_array[@array_y][@array_x-1] == 1)
		end
	end

	def findright
		if @x == @width
			return false
		else
			return !(@maze_array[@array_y][@array_x+1] == 1)
		end
	end
			
			
			
end
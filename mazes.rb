# encoding: utf-8
class Maze

	def initialize(x, y)
		@width = x
		@height = y
		@maze_string
		@maze_array = Array.new
		@maze_string_split
		@currCell
	end


	def load x
		@maze_string = x
		@maze_string_split = x.chars.to_a
		counter = 0

		#generates a 2d array from the string
		(0...(@height*2+1)).each do |n|
			@maze_array[n] = Array.new

			(0...(@width*2+1)).each do |m|
				@maze_array[n][m]=@maze_string_split[counter]
				counter +=1			
			end
		end
	end

	def display
		#level determines whether to use '|' or '+' and '-'
		level = 0
		#type determines whether to use '+' or '-'
		type = 0
		counter = 0
		#counter keeps track of the line switches for level 1
		@maze_array.each do |y|
			#switch for the levels
			if level == 1
				level = 0
			elsif level == 0
				level = 1
			end
			y.each do |x|
				if level == 0
					if x == '1'
						print '|'
					elsif x == '0'
						print " "
					end

				elsif level == 1
					if x == '1' && type == 0
						print '+'
						type = 1
					elsif x =='1' && type == 1
						print '-'
						type = 0
					elsif x == '0' && type == 0
						print ' '
						type = 1
					elsif x == '0' && type == 1
						print ' '
						type = 0
					end
					counter+=1
					if counter == @width*2+1
						if type == 0
							type = 1
						else
							type = 0
						end
						counter = 0
					end
				end				
			end
			puts ''
		end
	end

	def solve(x1, y1, x2, y2)
		#just in case, this is to reduce redundancy
		if x1 == x2 && y1 == y2
			return true
		end
		#makes a hash of all cells in the maze
		cell_hash = Hash.new
		(0...@width).each do |w|
			(0...@height).each do |h|
				key_str = w.to_s + h.to_s
				cell_hash.store(key_str, Cell.new(w,h,@width,@height,@maze_array))
			end
		end
		#Breadth first search, uses a queue, adds cells accessible from the current cell
		current = cell_hash[x1.to_s+y1.to_s]
		current.visited = true
		progress = Queue.new
		progress.enq(current)
		path = false
		while progress.empty? == false do
			temp = progress.pop
			if temp.x == x2 && temp.y == y2
				path = true
				break
			end

			if temp.up == true
				checker = cell_hash[temp.x.to_s + (temp.y-1).to_s]
				if checker.visited == false
					checker.visited = true
					progress.enq(checker)
				end
			end
			if temp.down == true
				checker = cell_hash[temp.x.to_s + (temp.y+1).to_s]
				if checker.visited == false
					checker.visited = true
					progress.enq(checker)
				end
			end
			if temp.left == true
				checker = cell_hash[(temp.x-1).to_s + temp.y.to_s]
				if checker.visited == false
					checker.visited = true
					progress.enq(checker)
				end
			end
			if temp.right == true
				checker = cell_hash[(temp.x+1).to_s + temp.y.to_s]
				if checker.visited == false
					checker.visited = true
					progress.enq(checker)
				end
			end
		end
		return path
	end


	
	#very similar to solve()
	def trace(x1, y1, x2, y2)
		cell_hash = Hash.new
		(0...@width).each do |w|
			(0...@height).each do |h|
				key_str = w.to_s + h.to_s
				cell_hash.store(key_str, Cell.new(w,h,@width,@height,@maze_array))
			end
		end
		current = cell_hash[x1.to_s+y1.to_s]
		current.visited = true
		progress = Queue.new
		progress.enq(current)
		#prints the first cell and sets up a counter to label the next steps
		counter = 1
		puts "#{counter}: (#{current.x},#{current.y})"
		counter +=1

		path = false
		while progress.empty? == false do
			temp = progress.pop
			if temp.x == x2 && temp.y == y2
				path = true
				break
			end

			if temp.up == true
				checker = cell_hash[temp.x.to_s+ (temp.y-1).to_s]
				if checker.visited == false
					checker.visited = true
					progress.enq(checker)
					puts "#{counter}: (#{checker.x},#{checker.y})"
					counter +=1
				end
			end
			if temp.down == true
				checker = cell_hash[temp.x.to_s+ (temp.y+1).to_s]
				if checker.visited == false
					checker.visited = true
					progress.enq(checker)
					puts "#{counter}: (#{checker.x},#{checker.y})"
					counter +=1
				end
			end
			if temp.left == true
				checker = cell_hash[(temp.x-1).to_s+ temp.y.to_s]
				if checker.visited == false
					checker.visited = true
					progress.enq(checker)
					puts "#{counter}: (#{checker.x},#{checker.y})"
					counter +=1
				end
			end
			if temp.right == true
				checker = cell_hash[(temp.x+1).to_s+ temp.y.to_s]
				if checker.visited == false
					checker.visited = true
					progress.enq(checker)
					puts "#{counter}: (#{checker.x},#{checker.y})"
					counter +=1
				end
			end
		end
	end

	def redesign
		temp_char_array = @maze_string.chars.to_a
		walls = Array.new
		counter = @width*2+3
		level = 0
		minicounter0 = 1
		minicounter1 = 1
		#makes an array of all the values that can be changed (very few)
		(1..(@width-1)*(@height-1)).each do |x|
			if level == 0
				if minicounter0 == 3
					walls.push(counter)
					counter += 4
					level = 1
					minicounter0 = 1
				else
					walls.push(counter)
					counter += 2
					minicounter0 +=1
				end

			elsif level == 1
				if minicounter1 == 4
					walls.push(counter)
					counter += 4
					level =0
					minicounter1 =1
				else
					walls.push(counter)
					counter +=2
					minicounter1 +=1
				end
			end
		end

		#changes said values
		(0..temp_char_array.length).each do |c|
			if walls.include?(c)
				r = Random.new
				temp_char_array[c]=r.rand(2)
			end
		end
		load(temp_char_array.join)
	end

end

#represents one position in the maze
class Cell

	def initialize(x, y, w, h, arr)
		@x = x
		@y = y
		@width = w
		@height = h
		@maze_array = arr
		@array_x = 2*x+1
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
	
	#each of these sees if the way is clear in a certain direction
	def findup
		if @y == 0
			return false
		else
			return !(@maze_array[@array_y-1][@array_x] == 1)
		end
	end

	def finddown
		if @y == @height-1
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
		if @x == @width-1
			return false
		else
			return !(@maze_array[@array_y][@array_x+1] == 1)
		end
	end			
end

m = Maze.new(4, 4)
m.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")
m.display
b = m.solve(0,0,0,3)
puts ''
puts b
puts ''
m.trace(0,0,3,3)
m.redesign
puts ''
m.display
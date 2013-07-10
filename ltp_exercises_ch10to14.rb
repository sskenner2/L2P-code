# NOTE : exercises completed from bottom to the top #
# Encoding: utf-8
# require 'pry'

# exercises ch 10-14

#####################################
# CH 14 Blocks and Procs
#####################################

#####################################
# Better Program Logger

# .. could ..
$logger_depth = 0

def log desc, &block
  prefix = '  '*$logger_depth

  puts prefix + 'Beginning "' + desc + '"...'

  $logger_depth = $logger_depth + 1
  result = block.call

  $logger_depth = $logger_depth - 1
  puts prefix + '..."' + desc + '" finished, returning: ' + result.to_s
end

log 'outer block' do
  log 'some little block' do
    log 'teeny-tiny block' do
      'lOtS oF lOVe'.downcase
    end

    7 * 3 * 2
  end

  log 'yet another block' do
    '!doof naidnI evol I'.reverse
  end

  '0' == "0"
end

#####################################
# Program Logger

# .. would ..
def log desc, &block
  puts "Beginning #{desc.inspect}..."
  result = block[]
  puts "...#{desc.inspect} finished, returning: #{result}"
end

log 'outer block' do
  log 'some little block' do
    1**1 + 2**2
  end

  log 'yet another block' do
    '!doof iahT ekil I'.reverse
  end

  '0' == 0
end

#####################################
# .. could ..
def log desc, &block
  puts 'begining "' + desc + '"...'
  result = block.call
  puts '..."' + desc + '" finished, returning:  ' + result.to_s
end
log 'outer block' do
  log 'some little block' do
    1**1 + 2**2
  end

  log 'yet another block' do
    '!doof iahT ekil I'.reverse
  end

  '0' == 0
end

#####################################
# Grandfather Clock

# .. would ..
def grandfather_clock &block
  hour = (Time.new.hour + 11)%12 + 1

  hour.times(&block)
end

grandfather_clock { puts 'DONG!' }

#####################################
# .. could ..
def grandfather_clock &block
  hour = Time.new.hour

  if hour >= 13
    hour = hour - 12
  end

  if hour == 0
    hour = 12
  end

  hour.times do
    block.call
  end
end
grandfather_clock do
  puts 'DONG!'
end

#####################################
# Even Better Profiling
# .. would ..
$OPT_PROFILING_ON = true

def profile block_description, &block
  if $OPT_PROFILING_ON
    start_time = Time.new
    block[]
    duration = Time.new - start_time
    puts "#{block_description}: #{duration} seconds"
  else
    block[]
  end
end

#####################################
# .. could ..
def profile block_description, &block
  # set this to true/false to turn profiling off

  profiling_on = true

  if profiling_on
    start_time = Time.new
    block.call

    duration = Time.new - start_time
    puts "#{block_description}: #{duration} seconds"
  else
    block.call
  end
end

#####################################
profile '25000 doublings' do
  number = 1

  25000.times do
    number = number + number
  end

  puts "#{number.to_s.length} digits"
  # the number of digits in this HUGE number
end

profile 'count to a million' do
  number = 0
  1000000.times do
    number = number + 1
  end
end

#####################################
# A1.10 Exercises from Chapter 13

# Interactive Baby Dragon
# .. could && would ..
class Dragon
  def initialize name
    @name = name
    @asleep = false
    @stuff_in_belly = 10    # he's full
    @stuff_in_intestine = 0   # he doesnt need to go

    puts "#{@name} is born."
  end

    def feed
    puts "You feed #{@name}."
    @stuff_in_belly = 10
    passage_of_time
  end

  def walk
    puts "You walk #{@name}."
    @stuff_in_intestine = 0
    passage_of_time
  end

  def put_to_bed
    puts "You put #{@name} to bed."
    @asleep = true
    3.times do
      if @asleep
        passage_of_time
      end
      if @asleep
        puts "#{@name} snores, filling the room with smoke."
      end
    end
    if @asleep
      @asleep = false
      puts "#{@name} wakes up slowly."
    end
  end

  def toss
    puts "you toss #{@name} up in the air."
    puts 'He giggles, which singes your eyebrows.'
    passage_of_time
  end
  def rock
    puts "you rock #{@name} gently."
    @asleep = true
    puts 'he briefly dozes off ...'
    passage_of_time
    if @asleep
      @asleep = false
      puts '... but wakes when you stop.'
    end
  end

  private
  # methods internal to the object

  def hungry?
    # methods that return true or false
    @stuff_in_belly <= 2
  end

  def poopy?
    @stuff_in_intestine >= 8
  end

  def passage_of_time
    if @stuff_in_belly > 0
      # mv from belly to intestine
      @stuff_in_belly = @stuff_in_belly - 1
      @stuff_in_intestine = @stuff_in_intestine + 1
    else
      if @asleep
        @asleep = false
        puts 'he wakes up suddenly!'
      end
      puts "#{@name} is starving! in desperation, he ate YOU!"
      exit # quits the program
    end

    if @stuff_in_intestine >= 10
      @stuff_in_intestine = 0
      puts "Whoops! #{@name} had an accident .."
    end

    if hungry?
      if @asleep
        @asleep = false
        puts 'He wakes up suddenly!'
      end
      puts "#{@name}'s stomach grumbles..."
    end

    if poopy?
      if @asleep
        @asleep = false
        puts 'he wakes up suddenly!'
      end
      puts "#{@name} does the potty dance..."
    end
  end
end

# .. would ..

puts 'what would u like to name your baby dragon?'
name = gets.chomp
pet = Dragon.new name
obj = Object.new    # blank dummy object

while true
  puts
  puts 'commands: feed, toss, walk, rock, put_to_bed, exit'

  command = gets.chomp

  if command == 'exit'
    exit
  elsif pet.respond_to?(command) && !obj.respond_to?(command)
    # want to only accept methods that dragons have, but
    # that regular objects *don't* have
    pet.send command
  else
    puts 'hunh? please type one of the commands.'
  end
end

#####################################
# .. could ..
puts 'what would u like to name your baby dragon?'
name = gets.chomp
pet = Dragon.new name

while true
  puts
  puts 'commands: feed, toss, walk, rock, put to bed, exit'
  command = gets.chomp

  if command == 'exit'
    exit
  elsif command == 'feed'
    pet.feed
  elsif command == 'toss'
    pet.toss
  elsif command == 'walk'
    pet.walk
  elsif command == 'rock'
    pet.rock
  elsif command == 'put to bed'
    pet.put_to_bed
  else
    puts 'huh? please type one of the commands.'
  end
end

#####################################
# Orange Tree
# .. could ..
class OrangeTree
	def initialize
		@height	= 0
		@orange_count = 0
		@alive = true
	end

	def height
		if @alive
			@height
    else
      'a dead tree is not very tall. :('
    end
  end

  def count_the_oranges
    if @alive
      @orange_count
    else
      'a dead tree has no oranges. :('
    end
  end

  def one_year_passes
    if @alive
      @height = @height + 0.4
      @orange_count = 0  # old oranges fall off
      if @height > 10 && rand(2) > 0
        # tree dies
        @alive = false
        'oh no! the tree is too old, and has died. :('
      elsif @height > 2
        # new oranges grow
        @orange_count = (@height * 15 - 25).to_i
        "this year ur tree grew to #{@height}m tall," +
        " and produced #{@orange_count} oranges."
      else
        "this year ur tree grew to #{height}m tall," +
        " but is still too young to bear fruit."
      end
    else
      'a year later, the tree is still dead. :('
    end
  end

  def pick_an_orange
    if @alive
      if @orange_count > 0
        @orange_count = @orange_count - 1
        'u pick a juicy, delicious orange!'
      else
        'u search every branch, bu find no oranges.'
      end
    else
      'a dead tree has nothing to pick. :('
    end
  end
end
ot = OrangeTree.new
23.times do
  ot.one_year_passes
end
puts(ot.one_year_passes)
puts(ot.count_the_oranges)
puts(ot.height)
puts(ot.one_year_passes)
puts(ot.one_year_passes)
puts(ot.one_year_passes)
puts(ot.one_year_passes)
puts(ot.one_year_passes)
puts(ot.height)
puts(ot.count_the_oranges)
puts(ot.pick_an_orange)

#####################################
# extend the built-in class
# .. would ..
class Array
	def shuffle
		sort_by{rand} 	# 'self' is implied remember?
	end
end
class Integer
	def factorial
		raise 'Must not use negative integer' if self < 0
		(self <= 1) ? 1 : self * (self-1).factorial
	end
	def to_roman
		#
		raise 'Must use positive integer' if self <= 0

		roman = ''
		roman << 'M' * (self/10000)
		roman << 'D' * (self % 10000 / 500)
		roman << 'C' * (self % 500 / 100)
		roman << 'L' * (self % 100 / 50)
		roman << 'X' * (self % 50 / 10)
		roman << 'V' * (self % 10 / 5)
		roman << 'I' * (self % 5 / 1)

		roman
	end
end

p 7.factorial.to_roman.split(//).shuffle

#####################################
# .. could ..
class Array
	def shuffle
		arr = self
		# copy the old shuffle method
		shuf = []

		while arr.length > 0
			# randomly pick one element of the array
			rand_index = rand(arr.length)

			# go thru each element in the array, putting
			#them all into new_arr except for the randomly
			#chosen one, which goes into shuffle
			curr_index = 0
			new_arr = []
			arr.each do |item|
				if curr_index == rand_index
					shuf.push item
				else
					new_arr.push item
				end

				curr_index = curr_index + 1
			end

			# replace orig arry w/ new, smaller array
			arr = new_arr
		end
		shuf
	end
end
class Integer
	def factorial
		if self <= 1
			1
		else
			self * (self-1).factorial
		end
	end
	def to_roman
		# old school roman numerals to save space
		roman = ''

		roman = roman + 'M' * (self/10000)
		roman = roman + 'D' * (self % 10000 / 500)
		roman = roman + 'C' * (self % 500 / 100)
		roman = roman + 'L' * (self % 100 / 50)
		roman = roman + 'X' * (self % 50 / 10)
		roman = roman + 'V' * (self % 10 / 5)
		roman = roman + 'I' * (self % 5 / 1)

		roman
	end
end

puts [1, 2, 3, 4, 5].shuffle
puts 7.factorial
puts 73.to_roman

#####################################
# A1.9 Exercises ch 12
#####################################

#####################################
#birthday helper
# .. would ..
# load in the birthdays
birth_days = {}

File.readlines('birthdates.txt').each do |line|
  name, date, year = line.split(',')
  birth_days[name] = Time.gm(year, *(date.split))
end

# now ask which one the user wants
puts 'whose birthday would you like to know?'
name = (gets.capitalize).chomp
bday = birth_days[name]

if bday == nil
  puts "oooh, i don't know that one..."
else
  now = Time.new
  age = now.year - bday.year

  if now.month > bday.month || (now.month == bday.month && now.day > bday.day)
    age += 1
  end

  if now.month == bday.month && now.day == bday.day
    puts "#{name} turn #{age} TODAY!!"
  else
    date = bday.strftime "%b %d"
    puts "#{name} will be #{age} on #{date}."
  end
end

#####################################
# .. could ..
# load in the b-days
birth_dates = {}
File.read('birthdates.txt').each_line do |line|
  # find the index of the first comma
  #so we know where the name ends
  first_comma = 0
  while line[first_comma] != ',' && first_comma < line.length
    first_comma = first_comma + 1
  end

  name = line[0..(first_comma - 1)]
  date = line[-13..-1]

  birth_dates[name] = date
end

# ask which one the user wants to know
puts 'whose b_day would you like to know?'
name = (gets.capitalize).chomp
date = birth_dates[name]

if date == nil
  puts "oooh, i don't know that one..."
else
  puts date[0..11]
end

#####################################
#party like it's roman_to_integer mcmxcix!

# .. would ..
def roman_to_integer roman
  digit_vals =   {'i' => 1,
                  'v' => 5,
                  'x' => 10,
                  'l' => 50,
                  'c' => 100,
                  'd' => 500,
                  'm' => 1000}
  total = 0
  prev = 0
  roman.reverse.each_char do |c_or_C|
    c = c_or_C.downcase
    val = digit_vals[c]
    if !val
      puts 'this is not a valid roman numeral!'
      return
    end
    if val < prev
      val *= -1
    else
      prev = val
    end

    total += val
  end

  total
end

puts(roman_to_integer('mcmxcix'))
puts(roman_to_integer('CCCLXV'))

#####################################
#.. could ..
def roman_to_integer roman
  digit_vals =   {'i' => 1,
                  'v' => 5,
                  'x' => 10,
                  'l' => 50,
                  'c' => 100,
                  'd' => 500,
                  'm' => 1000}
  total = 0
  prev = 0
  index = roman.length - 1
  # puts index
  while index >= 0
    c = roman[index].downcase
    index = index - 1
    val = digit_vals[c]
    if !val
      puts 'this is not a valid roman numeral!'
      return
    end
    puts val
    puts 'is val < prev?'
    puts prev
    if val < prev
      val = val * (-1)
      puts 'yes it is'
      puts val
    else
      prev = val
    end
    total = total + val
    puts 'this is total'
    puts total
    puts '----'
  end

  total
end

#puts(roman_to_integer('mcmx'))
puts(roman_to_integer('mcmxcix'))
#puts(roman_to_integer('CCCLXV'))

#####################################
# happy b-day

# .. would ..
puts 'hey, when were you born? (pls use YYYYMMDD format)'
input = gets.chomp

b_year = input[0..3].to_i
b_month = input[4..5].to_i
b_day = input[6..7].to_i

t = Time.new

t_year = t.year
t_month = t.month
t_day = t.day

age = t_year - b_year

if t_month < b_month || (t_month == b_month && t_day < b_day)
  age -= 1
  # puts age
end

if t_month == b_month && t_day == b_day
  puts 'HAPPY BIRTHDAY!'
end

age.times { puts 'SPANK!' }

#####################################
# .. could do it ..

puts 'what year were u born?'
b_year = gets.chomp.to_i

puts 'what month were you born?'
b_month = gets.chomp.to_i

puts 'what day of the month were you born?'
b_day = gets.chomp.to_i

b = Time.local(b_year, b_month, b_day)
t = Time.new

age = 1   # for 1st actual bday

while Time.local(b_year + age, b_month, b_day) <= t
  puts 'SPANK!'
  puts b_year + age
  age = age + 1
end

#####################################
# one billion seconds
# .. would do it

 dont know what second author was born
 puts(Time.gm(1976, 8, 3, 13, 31) + 10**9)
 puts(Time.gm(1975, 8, 12, 0, 0) + 10**9)
 puts(Time.gm(2004, 1, 5, 0, 0) + 10**9)
 puts(Time.gm(2008, 6, 25, 0, 0) + 10**9)

#####################################
#ch11
#####################################

#####################################
#build a better playlist
# .. would do it

def music_shuffle filenames
  songs_and_paths = filenames.map do |s|
    [s, s.split('/')]   # [song, path]
  end

  tree = {:root => []}

  # put ea song into the tree
  insert_into_tree = proc do |branch, song, path|
    if path.length == 0  # add to current branch
      branch[:root] << song
    else  # delve deeper
      sub_branch = path[0]
      path.shift    # pops off the front

      if !branch[sub_branch]
        branch[sub_branch] = {:root => []}
      end

      insert_into_tree[branch[sub_branch], song, path]
    end
  end

  songs_and_paths.each{|sp| insert_into_tree[tree, *sp]}

  # recursively:
  # => - shuffle sub-branches (and root)
  # => - weight ea sub-branch (and root)
  # => - merge (shuffle) these groups together
  shuffle_branch = proc do |branch|
    shuffled_subs = []

    branch.each do |key, unshuffled|
      shuffled_subs << if key == :root
        unshuffled    # at this level, these are all dupes
      else
        shuffle_branch[unshuffled]
      end
    end

    weighted_songs = []

    shuffled_subs.each do |shuffled_songs|
      shuffled_songs.each_with_index do |song, idx|
        num = shuffled_songs.length.to_f
        weight = (idx + rand) / num
        weighted_songs << [song, weight]
      end
    end

    weighted_songs.sort_by{|s,v| v}.map{|s,v| s}
  end

  shuffle_branch[tree]
end

songs = ['aa/bbb', 'aa/ccc', 'aa/ddd', 'AAA/xxxx', 'AAA/yyyy', 'AAA/zzzz', 'foo/bar']

puts(music_shuffle(songs))

#####################################
# .. could do it
def music_shuffle filenames
  # dont want a perfectly random shuffle . shuffle like card shuffling
  #shuffle the deck twice, then cut it once ..
  #  actually *sort* the input
  filenames = filenames.sort
  len = filenames.length

  # shuffle twice
  2.times do
    l_idx = 0   # index of next card in the left pile
    r_idx = len/2   # index of next card in the right pile
    shuf = []
    # NOTE: if we have a odd number of "cards", then the
    #right pile will be larger

    while shuf.length < len
      if shuf.length%2 == 0
        # take card from the right pile
        shuf.push(filenames[r_idx])
        r_idx = r_idx + 1
      else
        # take card from the left pile
        shuf.push(filenames[l_idx])
        l_idx = l_idx + 1
      end
    end

    filenames = shuf
  end
  # cut the deck
  arr = []
  cut = rand(len)   # index of card to cut at
  idx = 0

  while idx < len
    arr.push(filenames[(idx+cut)%len])
    idx = idx + 1
  end

  arr
end
songs = ['aa/bbb', 'aa/ccc', 'aa/ddd', 'AAA/xxxx', 'AAA/yyyy', 'AAA/zzzz', 'foo/bar']

puts(music_shuffle(songs))

#####################################
# build your own playlist
# .. could and would do it

def shuffle arr
	arr.sort_by{rand}
end
p(shuffle([1,2,3,4,5,6,7,8,9]))
#using the shuffle method above
all_oggs = shuffle(Dir['**/*.ogg'])

File.open 'plalist.m3u', 'w' do |f|
  all_oggs.each do |ogg|
    f.write ogg+"\n"
  end
end
puts "Done!"

#####################################
# safer picture downloading
# >> see p148

#####################################
#ch 10
#####################################

# 10.5 A Few More Things to Try
# “Ninety-nine Bottles of Beer on the Wall.” Using english_number
# Expanded english_number.
def english_number number
	if number < 0 # no neg #'s
		return 'pls enter a # that is not negative'
	end
	if number == 0
		return 'zero'
	end

	# no special cases .. no returns
	num_string = '' # we will return this string
	ones_place = ['one', 'two', 'three',
				'four', 'five', 'six',
				'seven', 'eight', 'nine']
	tens_place = ['ten', 'twenty', 'thirty',
				'forty', 'fifty', 'sixty',
				'seventy', 'eighty', 'ninety']
	teenagers = ['eleven', 'twelve', 'thirteen',
				'fourteen', 'fifteen', 'sixteen',
				'seventeen', 'eighteen', 'nineteen']
	zillions = [['hundred', 2],
				['thousand', 3],
				['million', 6],
				['billion', 9],
				['trillion', 12],
				['quadrillion', 15],
				['quintillion', 18],
				['sextillion', 21],
				['septillion', 24],
				['octillion', 27],
				['nonillion', 30],
				['decillion', 33],
				['undecillion', 36],
				['duodecillion', 39],
				['tredecillion', 42],
				['quattuordecillion', 45],
				['quindecillion', 48],
				['sexdecillion', 51],
				['septendecillion', 54],
				['octodecillion', 57],
				['novemdecillion', 60],
				['vigintillion', 63],
				['googol', 100]]

	# 'left' = how much of the num still hv left to write out
	# 'write' = the part we are writing out right now
	left = number

	while zillions.length > 0
		zil_pair = zillions.pop
		zil_name = zil_pair[0]
		zil_base = 10 ** zil_pair[1]
		write = left/zil_base  # how many zillions left?
		left = left - write * zil_base  # subtract off zillions

		if write > 0
			# .. the recursion:
			prefix = english_number write
			num_string = num_string + prefix + ' ' + zil_name

			if left > 0
				# to correct if 'two billionfifty-one' ..
				num_string = num_string + ' '
			end
		end
	end

	write = left/10  # how many tens left
	left = left - write * 10  # subtract off tens

	if write > 0
		if ((write == 1) and (left > 0))
			# special exception to prevent 'tenty-two'
			num_string = num_string + teenagers[left-1]
			# '-1' bc teenagers[3] is 'fourteen'
			# digit in ones place sorted .. nothing left to write
			left = 0
		else
			num_string = num_string + tens_place[write-1]
			# '-1' bc tens_place[3] is 'forty'
		end

		if left > 0
			# to prevent write 'sixtyfour'
			num_string = num_string + '-'
		end
	end

	write = left  # how many ones left to write out?
	left = 0  # subtract off those ones

	if write > 0
		num_string = num_string + ones_place[write-1]
		# '-1' bc ones_place[3] is four not ..
	end

	num_string
end

# “Ninety-nine Bottles of Beer on the Wall.”
# .. would ..

num_at_start = 5

num_bot = proc { |n| "#{english_number n} bottle#{n == 1 ? '' : 's'}" }

num_at_start.downto(2) do |num|
	bottles =
	puts "#{num_bot[num]} of beer on the wall, #{num_bot[num]} of beer!".capitalize
	puts "take one down, pass it around, #{num_bot[num-1]} of beer on the wall!"
end
puts "#{num_bot[1]} of beer on the wall, #{num_bot[1]} of beer!".capitalize
puts "take one down, pass it around, no more bottles of beer on the wall!"

#####################################
# .. could ..
num_at_start = 5  # try 9999 ..
num_now = num_at_start
while num_now > 2
	puts english_number(num_now).capitalize + ' bottles of beer on the wall, ' + english_number(num_now) + ' bottles of beer!'
	num_now = num_now - 1
	puts 'take one down, pass it around, ' +
	english_number(num_now) + ' bottles of beer on the wall!'
end

puts "two bottles of beer on the wall, two bottles of beer!"
puts "take one down, pass it around, one bottle of beer on the wall!"
puts "one bottle of beer on the wall, one bottle of beer!"
puts "tke one down, pass it around, no more bottles of beer on the wall!"

puts english_number(0)
puts english_number(9)
puts english_number(10)
puts english_number(17)
puts english_number(32)
puts english_number(85)
puts english_number(99)
puts english_number(100)
puts english_number(234)
puts english_number(3211)
puts english_number(99999999)
puts english_number(100099999)
puts english_number(1000999998927348692376298375928370892309842038749237492)

#####################################
# dictionary sort
# .. could ..

def dictionary_sort arr   ## this is a wrapper method ..
	rec_dict_sort arr, [] ## when trying to sort an array,
end						  ## this passes in an empty array
						  ## for the second array parameter
def rec_dict_sort unsorted, sorted
	if unsorted.length <= 0
		return sorted
	end
	# if here then there is still work to do

	smallest = unsorted.pop
	still_unsorted = []

	unsorted.each do |tested_object|
		if tested_object.downcase < smallest.downcase
			# when tested_object < smallest
			still_unsorted.push smallest
			smallest = tested_object
		else
			still_unsorted.push tested_object
		end
	end
	# now 'smallest' really does point to the smallest
	# element that 'unsorted' contained, and all the
	# rest of it is in 'still_unsorted'
	sorted.push smallest

	rec_dict_sort still_unsorted, sorted
end

#puts(dictionary_sort(['can','feel','singing','like','A','can']))
puts(dictionary_sort(['cat','big','A']))

#####################################
# shuffle
# .. would do it

def shuffle arr
	arr.sort_by{rand}
end

p(shuffle([1,2,3,4,5,6,7,8,9]))

#####################################
# .. could do it
def shuffle arr
	shuf = []
	# returned array
	while arr.length > 0
		# randomly pick one element of the array
		rand_index = rand(arr.length)
		# rand_index = 4
		# now go thru ea item in the array, putting them
		# all into new_arr except for the randomly chosen
		# one, which goes into shuf

		curr_index = 0
		# tracks current index
		new_arr = []
		# ?????

		arr.each do |item|
			if curr_index == rand_index
				# 0 == 4 -> no
				# when 4 == 4
				shuf.push item
				# shuf = [5]
			else
				new_arr.push item
				# new_array = [1,2,3,4]
			end

			curr_index = curr_index + 1
			# curr_index = 1 .. 4
		end

		# replace the original array with the new, smaller
		# array

		arr = new_arr
		# arr = [1,2,3,4]
	end

	shuf
end

puts(shuffle([1,2,3]))
puts(shuffle([1,2,3,4,5,6,7,8,9]))

#####################################
# Rite of Passage: Sorting

# how i would do it

def sort arr
	return arr if arr.length <= 1

	middle = arr.pop
	less = arr.select{|x| x <  middle}
	more = arr.select{|x| x >= middle}

	sort(less) + [middle] + sort(more)
end

p(sort(['can', 'feel', 'singing', 'like', 'a', 'can']))


#####################################
# How u could do it:

def sort arr
	rec_sort arr, []
end

def rec_sort unsorted, sorted
	if unsorted.length <= 0
		return sorted
	end

	# if get to here then more work to do

	smallest = unsorted.pop

	still_unsorted = []

	unsorted.each do |tested_object|
		if tested_object < smallest
			still_unsorted.push smallest
			smallest = tested_object
		else
			still_unsorted.push tested_object
		end
	end
	# now "smallest" really points to the smallest element
	# that "unsorted" contained, and the rest of it is in
	# "still_unsorted"

	sorted.push smallest

	rec_sort still_unsorted, sorted
end

puts(sort(['can', 'feel', 'singing', 'like', 'a', 'can']))

#####################################
# ch 9
#####################################

#####################################
# “Modern” Roman Numerals
# How I would do it:

def roman_numeral num
	raise 'must use + integer' if num <= 0

	digit_vals =   [['I',	   5,	   1],
					['V',	  10,	   5],
					['X',	  50,	  10],
					['L',	 100,	  50],
					['C',	 500,	 100],
					['D',	1000,	 500],
					['M',	 nil,	1000]]
	roman = ''
	remaining = nil

	# build string "roman" in reverse.
	build_rev = proc do |l,m,n|
		num_l = m ? (num % m / n) : (num / n)
		full = m && (num_l == (m/n - 1))

		if full && (num_l>1 || remaining)
			# must carry
			ramaining ||= l #carry l if not already carrying
		else
			if remaining
				roman << l + remaining
				remaining = nil
			end

			roman << l * num_l
		end
	end

	digit_vals.each{|l,m,n| build_rev[l,m,n]}

	roman.reverse
end

puts (roman_numeral(1999))


# “Modern” Roman Numerals
# How you could do it:

def roman_numeral num

	thous = (num 		/ 1000)
	# 1599/1000 -> 1.599 <floor> 1
	hunds = (num % 1000 /  100)
		# % -> 599/100 -> 5.99 <floor> 5
	tens  = (num % 100 	/   10)
		# % -> 99/10 -> 9.9 <floor> 9
	ones  = (num % 10  )
		# % -> 9

	roman = 'M' * thous
		# 'M' * 1 -> M
	if hunds == 9
		roman = roman + 'CM'
	elsif hunds == 4
		roman = roman + 'CD'
	else
		roman = roman + 'D' * (num % 1000 / 500)
			# 'M'+'D'*[(599/500) -> 1.198<floor>] -> 'MD'
		roman = roman + 'C' * (num %  500 / 100)
			# 'MD'+'C'*[(99/100) -> 0.99<floor>] -> 'MD'
	end

	if tens == 9
		roman = roman + 'XC'
			# 'MDXC'
	elsif tens == 4
		roman = roman + 'XL'
	else
		roman = roman + 'L' * (num % 100 / 50)
		roman = roman + 'X' * (num %  50 / 10)
	end

	if ones == 9
		roman = roman + 'IX'
			# 'MDXCIX'
	elsif ones == 4
		roman = roman + 'IV'
	else
		roman = roman + 'V' * (num % 10 / 5)
		roman = roman + 'I' * (num %  5 / 1)
	end

	roman
end

puts(roman_numeral(1999))
	# MCMXCIX
puts(roman_numeral(1599))
	# MDXCIX


# Old-School Roman Numerals
# How I would do it:
def old_roman_numeral num
	raise 'must use + integer' if num <= 0
	roman = ''

	roman << 'M' * (num / 1000)
		# -> 1.925 -> 1 (floor)
	roman << 'D' * (num % 1000 / 500)
		# -> 925/500 -> 1.85 -> 1 (floor)
	roman << 'C' * (num % 500 / 100)
		# -> 425/100 -> 4.25 -> 4 (floor)
	roman << 'L' * (num % 100 / 50)
		# -> 25/50 -> 0.5 -> 0 (floor)
	roman << 'X' * (num % 50 / 10)
		# -> 25/10 -> 2.5 -> 2 (floor)
	roman << 'V' * (num % 10 / 5)
		# -> 5/5 -> 1 -> 1
	roman << 'I' * (num % 5 / 1)
		# -> 0/10 -> 0 -> 0

	roman
end
puts(old_roman_numeral(1925))


#####################################
# before ch 9
#####################################

# roman numerals
def roman_numeral num

	thous = (num 			/ 1000)
	hunds = (num 	% 1000 	/  100)
	tens  = (num 	% 100 	/   10)
	ones  = (num 	% 			10)

	roman = 'M' * thous

end

puts 'number please:'
num = gets.chomp.to_i

puts old_roman_numeral(num)

#####################################
# questionairre

puts 'info about the questionaire..'

while true
	puts 'do u like eating tacos'
	answer = gets.chomp.downcase
	if (answer == 'yes' || answer == 'no')
		break
	else
		puts 'please answer yes or no'
	end
end

while true
	puts 'do u like eating burritos'
	answer = gets.chomp.downcase
	if (answer  == 'yes' || answer == 'no')
		break
	else
		puts 'please answer yes or no'
	end
end

while true
	puts 'do u wet the bed'
	answer = gets.chomp.downcase
	if (answer == 'yes' || answer == 'no')
		if answer == 'yes'
			wets_bed = true
		else
			wets_bed = false
		end
		break
	else
		puts 'please answer yes or no'
	end
end

while true
	puts 'do u like eating chimis'
	answer = gets.chomp.downcase
	if (answer == 'yes' || answer == 'no')
		break
	else
		puts 'please answer yes or no'
	end

	puts 'just a few more questions...'

	while true
		puts 'do u like eating sopap'
		answer = gets.chomp.downcase
		if(answer == 'yes' || answer == 'no')
			break
		else
			puts 'please answer yes or no'
		end
	end
end

puts
puts 'debriefing .. thank you'
puts
puts wets_bed




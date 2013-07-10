#require 'pry'
#require 'pry-debugger'

# pc 6/27 >>>>>
# pc 6/27 >>>>>
# pc 6/27 >>>>>

# CH 14 Blocks and Procs

# 14.3 Passing Blocks (Not Procs) into Methods

=begin
def profile block_description, &block
  start_time = Time.new
  block.call
  duration = Time.new - start_time
  puts "#{block_description}: #{duration} seconds"
end

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
=end

=begin
class Array

  def each_even(&was_a_block_now_a_proc)
    # start w "true" bc arrays start w 0 (even)
    is_even = true

    self.each do |object|
      if is_even
        was_a_block_now_a_proc.call object
      end

      # toggle from even to odd, or odd to even
      is_even = !is_even
    end
  end

end

fruits = %w[apple bad_apple cherry durian]
fruits.each_even do |fruit|
  puts "Yum! i just love #{fruit} pies, dont you?"
end

# remember, we are getting the even-numbered *elements*
# which in this case are all od numbers
%w[1 2 3 4 5].each_even do |odd_ball|
  puts "#{odd_ball} is NOT an even number!"
end
=end

# 14.2 Methods That Return Procs

=begin
def compose proc1, proc2
  Proc.new do |x|
    proc2.call(proc1.call(x))
  end
end

square_it = Proc.new do |x|
  x * x
end

double_it = Proc.new do |x|
  x + x
end

double_then_square = compose double_it, square_it
square_than_double = compose square_it, double_it

puts double_then_square.call(5)
puts square_than_double.call(5)
=end

# 14.1 Methods That Take Procs

=begin
def do_until_false first_input, some_proc
  input = first_input
  output = first_input

  while output
    input = output
    output = some_proc.call input
  end

  input
end

build_array_of_squares = Proc.new do |array|
  last_number = array.last
  if last_number <= 0
    false
  else
    # take off last number ...
    array.pop 
    # ... and replace it with its square ...
    array.push last_number*last_number
    # ... followed by the next smaller number.
    array.push last_number-1
  end
end

always_false = Proc.new do |just_ignore_me|
  false
end

puts do_until_false([5], build_array_of_squares).inspect

yum = 'lemonade with a hint of orange blossom water'
puts do_until_false(yum, always_false)
=end

###################################################
=begin
def maybe_do some_proc
  if rand(2) == 0
    some_proc.call
  end
end

def twice_do some_proc
  some_proc.call
  some_proc.call
end

wink = Proc.new do
  puts '<wink>'
end

glance = Proc.new do
  puts '<glance>'
end

maybe_do wink
maybe_do wink
maybe_do glance
maybe_do glance
maybe_do wink
maybe_do glance
=end

=begin
def do_self_importantly some_proc
  puts "everybody just HOLD ON! i'm doin something..."
  some_proc.call
  puts "OK everyone, i'm done. as you were."
end

say_hello = Proc.new do
  puts 'hello'
end

say_goodbye = Proc.new do
  puts 'goodbye'
end

do_self_importantly say_hello
do_self_importantly say_goodbye
=end

=begin
do_you_like = Proc.new do |good_stuff|
  puts "i *really* like #{good_stuff}!"
end

do_you_like.call 'chocolate'
do_you_like.call 'Ruby'
=end

####### binding.pry the above to understanding #######
####### binding.pry the above to understanding #######
####### binding.pry the above to understanding #######
####### binding.pry the above to understanding #######

=begin
toast = Proc.new do
	puts 'Cheers!'
end

toast.call
toast.call
toast.call
=end

# ch 13 Creating New Classes, Changing Existing Ones

# 13.5 Baby Dragon

=begin
class Dragon
	def initialize name
		@name = name
		@asleep = false
		@stuff_in_belly = 10 		# he's full
		@stuff_in_intestine = 0		# he doesnt need to go

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

pet = Dragon.new 'Norbert'
pet.feed
pet.toss
pet.walk
pet.put_to_bed
pet.rock
pet.put_to_bed
pet.put_to_bed
pet.put_to_bed
pet.put_to_bed
=end


# 13.3 Instance Variables
=begin
class Die
	def initialize
		# the initial die roll
		roll
	end
	def roll
		@number_showing = 1 + rand(6)
	end
	
	def showing
		@number_showing
	end
end

puts Die.new.showing
=end

=begin
die = Die.new
die.roll
puts die.showing
puts die.showing
die.roll
puts die.showing
puts die.showing
=end

# creating classes
=begin
class Die
	def roll
		1 + rand(6)
	end
end
# mk a couple of dice
dice = [Die.new, Die.new]

# and roll em
dice.each do |die|
	puts die.roll
end
=end

# mac 6/20 >>>>> 
# win >>>>>>>>>> 
# win >>>>>>>>>> 

=begin
class Integer
  def to_eng
    if self == 5
      english = 'five'
    else
      english = 'forty-two'
    end

    english
  end
end

puts 5.to_eng
puts 42.to_eng
puts 50.to_eng # wack .. still forty-two
=end

# ch 12

# 12.7 Classes and the Class Class

=begin
puts(42.class)
puts("i'll have mayonnaise on mine!".class)
puts(Time.new.class)
puts(Time.class)
puts(String.class)

puts(Class.class)
=end

# 12.6 

=begin
def method_2
  if false
    'only if condition is true'
  else
      'only if condition is false'
  end
end

puts method_2
=end

# >>>>>>> mac
# >>>>>>> mac
# >>>>>>> mac

=begin
prof = "We tore the universe a new space-hole, alright!"
puts prof[12, 8]
puts prof[12..9] # 8 characters tot
puts
def is_avi? filename
  filename.downcase[-4..-1] == '.avi'
end

puts is_avi?('dancemonkeyboy.avi')

puts is_avi?('toilet_paper_fiasco.jpg')
=end

=begin
da_man = 'Mr. T'
big_T = da_man[4]
puts big_T

puts "Hello. My name is Julian."
puts "I'm extremely perceptive."
puts "What's your name?"

name = gets.chomp
puts "Hi, #{name}"

if name[0] == 'C' || name[0] == 'c'
  puts 'You have an excellent taste in footwear.'
  puts 'I can just tell.'
end
=end

=begin
god_bless_the_70s = 1970..1979
puts god_bless_the_70s.min
puts god_bless_the_70s.max
puts(god_bless_the_70s.include?(1979))
puts(god_bless_the_70s.include?(1980))
puts(god_bless_the_70s.include?(1974.5))
=end

=begin
# range literal
letters = 'a'..'c'

# convert range to array
puts(%w[a b c] == letters.to_a)

# iterate over a range
('A'..'Z').each do |letter|
  print letter
end
puts
=end

=begin
weird_hash = Hash.new

weird_hash[12] = 'monkeys'
weird_hash[[]] = 'emptiness'
weird_hash[Time.new] = 'no time like the present'

weird_hash
=end

=begin 
dict_array = []   # array literal; same as Array.new
dict_hash = {}    # hash literal; same as Hash.new

dict_array[0] = 'candle'
dict_array[1] = 'glasses'
dict_array[2] = 'truck'
dict_array[3] = 'Alicia'
dict_hash['shia-a'] = 'candle'
dict_hash['shaya'] = 'glasses'
dict_hash['shasha'] = 'truck'
dict_hash['sh-sha'] = 'Alicia'

#dict_array.each do |word|
#  puts word
#end
dict_array.each { |word| puts word }

#dict_hash.each do |c_word, word|
#  puts "#{c_word}: #{word}"
#end
dict_hash.each { |c_word, word| puts "#{c_word}: #{word}"}
=end

=begin
Time.gm(1955, 11, 5)  # a red letter day

Time.local(2000, 1, 1)           # Y2K
Time.local(1976, 8, 3, 13, 31)   # authors birth

puts Time.local(2000, 1, 1)           # Y2K
puts Time.local(1976, 8, 3, 13, 31)   # authors birth
=end

=begin
time = Time.new     # the moment we ran this code
time2 = time + 60   # one minute later

puts time
puts time2
=end

=begin

alpha = Array.new + [12345]   # array addition
beta = String.new + 'hello'   # string addition
karma = Time.new    # current date and time

puts "alpha = #{alpha}"
puts "beta = #{beta}"
puts "karma = #{karma}"

=end

# ch 11

=begin
require 'yaml'
#define these fancy methods
def yaml_save object, filename
  File.open filename, 'w' do |f|
    f.write(object.to_yaml)
  end
end
def yaml_load filename
  yaml_string = File.read filename

  YAML::load yaml_string
end
# .. now use these fancy methods
test_array = ['Slick Shoes', 'Bully Blinders', 'Pinchers of Peril']

filename = 'DatasGadget.txt'
# save it
yaml_save test_array, filename
# load it
read_array = yaml_load filename
# weep for those that aint got it
puts(read_array == test_array)
=end


#puts "#{2 * 10**4 + 1} Leauges Under the Sea, THE REVENGE!"

#name = 'Luke'
#zip = 90210

#puts "Nmae = #{name}, Zipcode = #{zip}"
#
#puts 'single (\') and double (") qoutes'
#puts "single (') and double (\") qoutes"
#
#puts '3...\n2...\n1...\nHAPPY NEW YEAR!'

#puts "3...\n2...\n1...\nHAPPY NEW YEAR!"
#
=begin
	
rescue Exception => e
	
end
buffy_qoute_1 = '\'kiss rocks\'?
				why would anyone want to kiss ..
				oh, wait. i get it.'
buffy_qoute_2 = "'kiss rocks'?\n" +
				"why would anyone want to kiss ..\n" +
				"oh, wait. i get it."
puts buffy_qoute_1
puts buffy_qoute_2
puts
puts (buffy_qoute_1 == buffy_qoute_2)

=begin 

## what is YAML used for ?????????????

require 'yaml'

test_array = ['Give Quiche A Chance',
				'Mutants Out!',
				'Chameleonic Life-Forms, No Thanks']

test_string = test_array.to_yaml

filename = 'RimmerTShirts.txt'

File.open filename, 'w' do |f|
	f.write test_string
end

read_string = File.read filename

read_array = YAML::load read_string

puts(read_string == test_string)
puts(read_array == test_array)

=begin
	
rescue Exception => e
	
end
filename = 'ListerQuote.txt'
test_string = 'I promise that I swear absolutely that ' +
				'I will never mention gazpacho soup again.'

File.open filename, 'w' do |f|
	f.write test_string
end

read_string = File.read filename

puts read_string
#puts(read_string == test_string)

# ch 10

=begin

# 10.4 One More Example
# english version of # w/ arrays

def english_number number
	if number < 0  # no neg numbers
		return 'pls enter num that is not negative'
	end
	if number == 0
		return 'zero'
	end

	# no more special cases .. no returns
	num_string = ''  # we will return this string

	ones_place = ['one',	'two',		'three',
				'four',		'five',		'six',
				'seven',	'eight',	'nine']
	tens_place = ['ten',	'twenty',	'thirty',
				'fourty',	'fifty',	'sixty',
				'seventy',	'eighty',	'ninety']
	teenagers = ['eleven',	'twelve',	'thirteen',
				'fourteen',	'fifteem',	'sixteen',
				'seventeen','eighteen',	'nineteen']

	# 'left' = how much of the num still hv left to write out
	# 'write' = the part we are writing out right now
	
	left = number
	write = left/100		# how many hundreds left
	left = left - write*100 # subtract off those hundreds

	if write > 0
		# here is the recursion:
		hundreds = english_number write
		num_string = num_string + hundreds + ' hundred '
		if left > 0
			# to not write 'two-hundredfifty-one' ...
			num_string + '' + num_string + ''
		end
	end

	write = left/10  # how many tens left
	left = left - write*10  # subtract those tens

	if write > 0
		if ((write == 1) and (left > 0))
			# special execption for 'twelve' et al
			num_string = num_string + teenagers[left - 1]
			# '-1' is bc teenagers[3] is 'fourteen' ...
			# digit in ones place sorted .. nothing left to write
			left = 0 
		else
			num_string = num_string + tens_place[write-1]
			# '-1' is bc tens_place is 'forty' not 'thirty'
		end
		if left > 0
			# so we dont write 'sixtyfour'
			num_string = num_string + '-'
		end
	end

	write = left  # how many ones left to write out
	left = 0   # subtract off those ones

	if write > 0 
		num_string = num_string + ones_place[write-1]
		# the '-1' is bc ones_place[3] is 'four' not ...
	end

	# return 'num_string'
	num_string
end

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

# english version of #

=begin
def english_number number

	# only accept #'s from 0 to 100
	if number < 0
		return 'please enter num 0 or greater'
	end
	if number > 100
		return 'please enter num 100 or less'
	end

	num_string = '' # string to be returned

	# 'left' how much num left to write out
	# 'write' the part of num currently writing now

	left = number
	write = left/100  # how many hundreds left
	left = left - write*100  # subtract off those hundreds

	if write > 0
		return 'one hundred'
	end

	write = left/10  #how many tens left?
	left = left - write*10  # subtract off those tens

	if write > 0
		if write == 1  # uh-oh ..
			# special exceptions for 11 - 20
			if left == 0
				num_string = num_string +'ten'
			elsif left == 1
				num_string = num_string +'eleven'
			elsif left == 2
				num_string = num_string +'twelve'
			elsif left == 3
				num_string = num_string +'thirteen'
			elsif left == 4
				num_string = num_string +'fourteen'
			elsif left == 5
				num_string = num_string +'fifteem'
			elsif left == 6
				num_string = num_string +'sixteen'
			elsif left == 7
				num_string = num_string +'seventeen'
			elsif left == 8
				num_string = num_string +'eighteen'
			elsif left == 9
				num_string = num_string +'nineteen'
			end
			# ones place sorted .. so done

			left = 0
		elsif left == 2
				num_string = num_string +'twenty'
		elsif left == 3
				num_string = num_string +'thirty'
		elsif left == 4
				num_string = num_string +'forty'
		elsif left == 5
				num_string = num_string +'fifty'
		elsif left == 6
				num_string = num_string +'sixty'
		elsif left == 7
				num_string = num_string +'seventy'
		elsif left == 8
				num_string = num_string +'eighty'
		elsif left == 9
				num_string = num_string +'ninety'
		end

		if left > 0
			num_string = num_string + '-'
		end
	end

	write = left  # how many ones left to write out?
	left = 0  # subtract off those ones
	if write > 0
		if write == 1  
			num_string = num_string +'one'
		elsif write == 2
			num_string = num_string +'two'
		elsif write == 3
			num_string = num_string +'three'
		elsif write == 4
			num_string = num_string +'four'
		elsif write == 5
			num_string = num_string +'five'
		elsif write == 6
			num_string = num_string +'six'
		elsif write == 7
			num_string = num_string +'seven'
		elsif write == 8
			num_string = num_string +'eight'
		elsif write == 9
			num_string = num_string +'nine'
		end
	end

	if num_string == ''
		# only way 'num_string' could be empty is if 
		# 'number' is 0
		return 'zero'
	end
	# if this far then we had na number in between 0 and
	# 100, so return 'num_string'
	num_string
end

puts english_number(0)
puts english_number(9)
puts english_number(10)
puts english_number(17)
puts english_number(32)
puts english_number(85)
puts english_number(99)
puts english_number(100)

=begin

M = 'land'
o = 'water'

world =	   [[o,o,o,o,o,o,o,o,o,o,o],
			[o,o,o,o,M,M,o,o,o,o,o],
			[o,o,o,o,o,o,o,o,M,M,o],
			[o,o,o,M,o,o,o,o,o,M,o],
			[o,o,o,M,o,M,M,o,o,o,o],
			[o,o,o,o,M,M,M,M,o,o,o],
			[o,o,o,M,M,M,M,M,M,M,o],
			[o,o,o,M,M,o,M,M,M,o,o],
			[o,o,o,o,o,o,M,M,o,o,o],
			[o,M,o,o,o,M,o,o,o,o,o],
			[o,o,o,o,o,o,o,o,o,o,o]]

def continent_size world, x, y
	# puts continent_size(world, 9, 2)
	# arr world[2][9] == 'land'
	if world[y][x] != 'land'
		# first test for what we dont want
		# either water or is land we already counted
		return 0
	end
	# so first we count this tile ...
	# initialize the counter
	size = 1
	# set position world[2][9] = 'counted land' to keep track
	world[y][x] = 'counted land'

	# ...then we count all of the neighboring eight tiles
	# (and their neighbors by way of recursion)

	size = size + continent_size(world, x-1, y-1)
	# size = 1 + continent_size(world, 8, 1) -> 1 + 0
	size = size + continent_size(world, x  , y-1)
	size = size + continent_size(world, x+1, y-1)
	size = size + continent_size(world, x-1, y  )
	size = size + continent_size(world, x+1, y  )
	size = size + continent_size(world, x-1, y+1)
	size = size + continent_size(world, x  , y+1)
	size = size + continent_size(world, x+1, y+1)
	size
end

#puts continent_size(world, 5, 5)
puts continent_size(world, 9, 2)


def factorial num
	if num < 0
		return 'u can\'t take factorial of a neg number!'
	end

	if num <= 1
		1
	else
		num * factorial(num - 1)
		# 3 * factorial(2) #> 3 * 2
		# 2 * factorial(1) #> 2 * 1
	end
end

puts factorial(3)
puts factorial(30)


def ask_recursively question
	puts question
	reply = gets.chomp.downcase

	if reply == 'yes'
		true
	elsif reply == 'no'
		false
	else
		puts 'please enter "yes" or "no"'
		ask_recursively question # the magic line
	end
end

ask_recursively 'do u wet the bed'


#ch 5 exs

puts 'what\'s your first name?'
f_name = gets.chomp
puts 'what\'s your middle name?'
m_name = gets.chomp

#ch 5 work
/
puts 'hello there, and what\'s your name?'
name=gets.chomp
puts 'your name is ' + name + '? What a lovely name!'
puts 'pleased to meet you, ' + name + '. :)'
/
/
var1 = 2
var2 = '5'
puts var1 + var2
/
/
var1 = 8
var2 = var1
puts var1
puts var2

puts ''

var1 = 'eight'
puts var1
puts var2
/

/
my_own_var = 'just another ' + 'string'
puts my_own_var

my_own_var = 5 * (1+2)
puts my_own_var
/

/
composer = 'Mozart'
puts composer + 'was "da bomb" in his day.'
composer = 'Beethoven'
puts 'But I prefer ' + composer + ', personally'
/

=end

# NOTE : exercises completed from bottom to the top #
# Encoding: utf-8
# require 'pry'

# exercises ch 1 - 9

###############################
# A1.6 Exercises from Chapter 9
###############################
###############################
# Modern Roman Numerals

# .. could
def roman_numeral num
  thous = (num / 1000)
  hunds = (num % 1000 / 100)
  tens = (num % 100 / 10)
  ones = (num % 10)

  roman = 'M' * thous
  if hunds == 9
    roman = roman + 'CM'
  elsif hunds == 4
    roman = roman + 'CD'
  else
    roman = roman + 'D' * (num % 1000 / 500)
    roman = roman + 'C' * (num % 500 / 100)
  end

  if tens == 9
    roman = roman + 'XC'
  elsif tens == 4
    roman = roman + 'XL'
  else
    roman = roman + 'L' * (num % 100 / 50)
    roman = roman + 'X' * (num % 50 / 10)
  end

  if ones == 9
    roman = roman + 'IX'
  elsif ones == 4
    roman = roman + 'IV'
  else
    roman = roman + 'V' * (num % 10 / 5)
    roman = roman + 'I' * (num % 5 / 1)
  end

  roman
end

puts 'gimmie a number:'
number = gets.chomp.to_i
puts(roman_numeral(number))

###############################
# Old-School Roman Numerals
# .. would
def old_roman_numeral num
  raise 'must use positive integer' if num<= 0
  roman = ''

  roman << 'M' * (num / 1000)
  roman << 'D' * (num % 1000 / 500)
  roman << 'C' * (num % 500 / 100)
  roman << 'L' * (num % 100 / 50)
  roman << 'X' * (num % 50 / 10)
  roman << 'V' * (num % 10 / 5)
  roman << 'I' * (num % 5 / 1)
  roman
end
puts 'gimmie a number:'
number = gets.chomp.to_i
puts(old_roman_numeral(number))

# .. could

def old_roman_numeral num

  roman = ''

  roman = roman + 'M' * (num / 1000)
  roman = roman + 'D' * (num % 1000 / 500)
  roman = roman + 'C' * (num % 500 / 100)
  roman = roman + 'L' * (num % 100 / 50)
  roman = roman + 'X' * (num % 50 / 10)
  roman = roman + 'V' * (num % 10 / 5)
  roman = roman + 'I' * (num % 5 / 1)
  roman
end
puts 'gimmie a number:'
number = gets.chomp.to_i
puts(old_roman_numeral(number))

###############################
# Improved ask Method

# .. would
def ask question
  while true
    puts question
    reply = gets.chomp.downcase
    return true if reply == 'yes'
    return false if reply == 'no'
    puts 'please answer "yes" of "no".'
  end
end
puts(ask('do you like eating tacos?'))

# .. could
def ask question
  while true
    puts question
    reply = gets.chomp.downcase
    if reply == 'yes'
      return true
    end
    if reply == 'no'
      return false
    end
    # if get this far then return and ask question again
    puts 'please answer "yes" or "no".'
  end
end
likes_it = ask 'do you like eating tacos?'
puts likes_it

###############################
# A1.5 Exercises from Chapter 8
###############################
###############################
# Table of Contents, Revisited

# .. would
title = 'table of contents'
chapters = [['getting started ', 1], ['numbers ', 9], ['letters', 13]]

puts title.center(50)
puts

chapters.each_with_index do |chap, idx|
  name, page = chap
  chap_num = idx + 1
  beginning = "chapter #{chap_num}: #{name}"
  ending = "page #{page}"

  puts beginning.ljust(30) + ending.rjust(20)
end

# .. could
title = 'table of contents'
chapters = [['getting started ', 1], ['numbers ', 9], ['letters', 13]]

puts title.center(50)
puts

chap_num = 1

chapters.each do |chap|
  name = chap[0]
  page = chap[1]

  beginning = 'chapter ' + chap_num.to_s + ':  ' + name
  ending = 'page ' + page.to_s

  puts beginning.ljust(30) + ending.rjust(20)
  chap_num = chap_num + 1
end

###############################
# Building and Sorting an Array
# .. would
puts 'gimmie some words .. i will sort them:'
words = []

while true
  word = gets.chomp
  break if word.empty?

  words << word
end
puts '.. here they are, sorted:'
puts words.sort

# .. could
puts 'gimmie some words .. i will sort them:'
words = []

while true
  word = gets.chomp
  if word == ''
    break
  end

  words.push word
end

puts '.. here they are, sorted:'
puts words.sort

###################################
# A1.4 Exercises from Chapter 7
###################################
###############################
# leap years

#.. would
puts 'pick a .. (like 1973 or something):'
starting = gets.chomp.to_i

puts 'now .. ending year:'
ending = gets.chomp.to_i

puts 'check it .. are leap years:'
(starting..ending).each do |year|
  next if year%4 != 0
  next if year%100 == 0 && year%400 != 0
  puts year
end

#.. could
puts 'pick a .. (like 1973 or something):'
starting = gets.chomp.to_i

puts 'now .. ending year:'
ending = gets.chomp.to_i

puts 'check it .. are leap years:'
year = starting

while year <= ending
  if year%4 == 0
    if year%100 != 0 || year%400 == 0
      puts year
    end
  end

  year = year + 1
end

###############################
# deaf grandma extended

# .. would
puts "hey .. peaches! give .. kiss!"
bye_count = 0
while true
  said = gets.chomp
  if said == 'BYE'
    bye_count += 1
  else
    bye_count = 0
  end
  break if bye_count >= 3

  response = if said != said.upcase
    'HUH?! SPEAK UP, SONNY!'
  else
    "no, not since #{1930 + rand(21)}!"
  end

  puts response
end

puts 'BYE-BYE CUPCAKE!'

# .. could
puts "hey .. peaches! give .. kiss!"
bye_count = 0
while true
 said = gets.chomp
 if said == 'BYE'
  bye_count = bye_count + 1
 else
  bye_count = 0
 end
 if bye_count >= 3
  puts 'BYE-BYE CUPCAKE!'
  break
 end
 if said != said.upcase
  puts 'huh?! speak up .. !'
 else
  random_year = 1930 + rand(21)
  puts 'no, not since ' + random_year.to_s + '!'
  end
end

###################################
# deaf grandma

# .. would

puts 'hey .. kiss!'
while true
  said = gets.chomp
  break if said == "BYE"
  response = if said != said.upcase
    'huh?! speak up, sonny!'
  else
    "no, not since #{1930 + rand(21)}!"
  end

  puts response
end

puts 'bye sweeite'


# .. could

puts 'hey .. kiss!'
while true
  said = gets.chomp
  if said == "BYE"
    puts 'BYE SWEETIE!'
    break
  end
  if said != said.upcase
    puts 'huh?! speak up, .. !'
  else
      random_year = 1930 + rand(21)
    puts 'no, not since ' + random_year.to_s + '!'
  end
end

#######################################
#“99 Bottles of Beer on the Wall”

# .. would
num_at_start = 5  # change to 99
num_bot = proc { |n| "#{ n } bottle#{ n == 1 ? ' ' : 's'}" }
num_at_start.downto(2) do |num|
  puts "#{num_bot[num]} of beer on the wall, #{num_bot[num]} of beer!"
  puts "take .. around, #{num_bot[num - 1]} of .. wall!"
end

puts "#{num_bot[1]} of .. wall, #{num_bot[1]} of .. beer!"
puts "take .. no more .. wall!"


# .. could
num_at_start = 5 # can change to 99
num_now = num_at_start
while num_now > 2
  puts num_now.to_s + ' bottles of beer on the wall, ' +
       num_now.to_s + ' bottles of beer!'
  num_now = num_now - 1

  puts 'take one down, pass it around, ' + num_now.to_s +
       ' bottles of beer on the wall!'
end

puts "2 bottles of beer on the wall, 2 bottles of beer!"
puts "take one down, pass it around, 1 bottle of beer on the wall!"
puts "1 bottle of beer on the wall, 1 bottle of beer!"
puts "take one down, pass it around, no more bottles of beer on the wall!"

###################################
#Table of Contents

# .. could
title = 'table of contents'.center(50)
chap_1 = 'chapter 1: getting started'.ljust(30) + 'page  1'.rjust(20)
chap_2 = 'chapter 2: numbers'.ljust(30) + 'page  9'.rjust(20)
chap_3 = 'chapter 3: letters'.ljust(30) + 'page 13'.rjust(20)
puts title
puts
puts chap_1
puts chap_2
puts chap_3

###################################
# Angry Boss

# .. would
names = %w[johnson smith weinberg filmore]
puts "can't you see i'm busy?! make it fast #{names[rand(4)].upcase}!"
request = gets.chomp
puts "whaaya mean \"#{request.upcase}\"?!? you're fired!!"

# .. could
puts 'can\'t you see i\'m busy?! make it fast johnson!'
request = gets.chomp
puts 'whaaya mean "' + request.upcase + '"?!? you\'re fired!!'

###################################
# A1.2 Exercises from Chapter 5
###################################
# Bigger, Better Favorite Number

# .. could/would

puts ' what\'s your favorite number?'
fav_num = gets.chomp.to_i
#better_num = fav_num + 1
puts "that\'s ok, ... but isn\'t #{fav_num + 1} just .. better?"
#puts 'that\'s ok, ... but isn\'t ' + better_num.to_s + ' just .. better?'

###################################
# Full Name Greeting

# .. could/would

puts 'what is your first name?'
f_name = gets.chomp
puts 'what is your middle name?'
m_name = gets.chomp
puts 'what is your last name?'
l_name = gets.chomp

puts "guess who is cooler than you, #{f_name} #{m_name} #{l_name} ..."
#full_name = f_name + ' ' + m_name + ' ' + l_name

#puts 'hello, ' + full_name + '!'

###################################
# A1.1 Exercises from Chapter 2
###################################
# Our Dear Author’s Age

# .. could/would ..

puts 1111000000 / (60 * 60 * 24 * 365)
puts 1195749524.778754 / (60 * 60 * 24 * 365)

#################################
# Your Age in Seconds

# .. would ..


puts(Time.new - Time.gm(1975, 8, 12))
puts(Time.new - Time.gm(1976, 8, 3, 13, 31))

# .. could ..

puts 60 * 60 * 24 * (365 * 32 + 9)

###################################
# Minutes in a Decade

# .. could ..

puts 60 * 24 * (365 * 10 + 2)

# .. would ..

# depends on how many leap years in a decade

puts "#{60 * 24 * (365 * 10 + 2)} or #{60 * 24 * (365 * 10 + 3)}"

###################################
# hours in year
# .. could ..

puts 24 * 365

# .. would ..

# depends if leap year

puts 24 * 365
puts "(or #{24 * 366} on occasion)"

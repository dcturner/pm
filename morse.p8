pico-8 cartridge // http://www.pico-8.com
version 15
__lua__
-- morse input logic
time_dot = 5
time_dash = time_dot * 2
time_proceed = time_dot * 3
timer_pressed = 0
timer_release = 0
morse_input = false
morse_key = 4
current_unit = ''
current_morse_string = ''
current_word = ''
morse_dictionary = {}
-- letters
morse_dictionary['.-'] = 'a'
morse_dictionary['-...'] = 'b'
morse_dictionary['-.-.'] = 'c'
morse_dictionary['-..'] = 'd'
morse_dictionary['.'] = 'e'
morse_dictionary['..-.'] = 'f'
morse_dictionary['--.'] = 'g'
morse_dictionary['....'] = 'h'
morse_dictionary['..'] = 'i'
morse_dictionary['.---'] = 'j'
morse_dictionary['-.-'] = 'k'
morse_dictionary['.-..'] = 'l'
morse_dictionary['--'] = 'm'
morse_dictionary['-.'] = 'n'
morse_dictionary['---'] = 'o'
morse_dictionary['.--.'] = 'p'
morse_dictionary['--.-'] = 'q'
morse_dictionary['.-.'] = 'r'
morse_dictionary['...'] = 's'
morse_dictionary['-'] = 't'
morse_dictionary['..-'] = 'u'
morse_dictionary['...-'] = 'v'
morse_dictionary['.--'] = 'w'
morse_dictionary['-..-'] = 'x'
morse_dictionary['-.--'] = 'y'
morse_dictionary['--..'] = 'z'
-- numbers
morse_dictionary['.----'] = '1'
morse_dictionary['..---'] = '2'
morse_dictionary['...--'] = '3'
morse_dictionary['....-'] = '4'
morse_dictionary['.....'] = '5'
morse_dictionary['-....'] = '6'
morse_dictionary['--...'] = '7'
morse_dictionary['---..'] = '8'
morse_dictionary['----.'] = '9'
morse_dictionary['-----'] = '0'

-- letter parser
function handler_release()
 morse_input = false
 timer_pressed = 0
 timer_release = 0
 current_morse_string = current_morse_string..current_unit
 current_unit = ''
end

function accept_letter_code(_letter)
 current_word = current_word.. _letter

end

function parse_current_morse_string()
 for key,value in pairs(morse_dictionary) do
  if(current_morse_string == key) then
   accept_letter_code(value)
  end
 end
 current_morse_string = ''
end

function update_morse_input()

-- input active
	if morse_input then
  if btn(0) == false then
   handler_release()
  else
   timer_pressed += 1
   if timer_pressed < time_dash then
    current_unit = '.'
   else
   current_unit = '-'
   end
  end
	else -- input inactive
  timer_release += 1
  if (timer_release == time_proceed and current_morse_string ~= '') then
   parse_current_morse_string()
  end
  if btn(0) then
   morse_input = true
  end
	end
end

-->8
-- updates

function _update()
	update_morse_input()
end
-->8
-- draws
function _draw()
cls()
print(current_morse_string..current_unit)
color(9)
print(current_word)
end

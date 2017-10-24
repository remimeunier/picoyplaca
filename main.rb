require './pico_y_placa'

if ARGV.length != 3
  abort("Wrong Number of arguments. Please enter 'ruby main.rb ABC-1234 DD/MM/YY HH:MM ")
end

puts plate_number = ARGV[0]
puts date         = ARGV[1]
puts time         = ARGV[2]

begin
  pico_y_placa = PicoYPlaca.new(plate_number: plate_number, date: date, time: time)
rescue PicoYPlaca::InvalidPlateError
  abort('Invalide plate. User ABC-1234 format')
rescue PicoYPlaca::InvalidDateError
  abort('Invalide date. Use DD/MM/YYYY format')
rescue PicoYPlaca::InvalidTimeError
  abort('Invalide Time. Use HH:MM format')
end

if pico_y_placa.can_ride?
  puts "You can drive the #{date} at #{time} with the #{plate_number} imatriculation"
else
  puts "You can't drive the #{date} at #{time} with the #{plate_number} imatriculation"
end

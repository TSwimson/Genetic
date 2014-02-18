require_relative 'population'

p = Population.new(500, 'HELLO')
o = p.start
if o != 0
  puts "Generation, #{p.gen_number}, found solution:"
  puts 'DNA: ' + o.dna.join
  puts 'DEC: ' + o.decode
else
  puts 'solution not found :('
end

# class Organism(target, chromosome)
# 	@@create a hash of letters A..Z + " " => 0..27
# 	-chromosome #array consisting of target.length #'s 0..27
# 	-fitness #how close the organism is to the goal
# 	*calculate_fitness # the sum of the abs of the difference of each element of the target array and the chromosome array
# 	*random_starting_chromosome
# 	*mutate

class Organism
	alpha = ("A".."Z").to_a << " "
	p alpha
	indexes = (0..26).to_a
	@@dna_encoder = Hash[alpha.zip indexes]
	@@dna_decoder = Hash[indexes.zip alpha]

	def initialize(target="HELLO WORLD", dna=nil, mutation_rate=0.05)
		@target = target
		@target_dna = @target.split("").map! { |e| @@dna_encoder[e]}
		@dna = dna
		@fitness = nil
		@mutation_rate = mutation_rate
		rand_start if !@dna
	end

	def update()
		mutate
		calculate_fitness
	end

	#private

	#Calculate the fitness by getting the sum if the difference of each element of the chromosome and target array
	def calculate_fitness
		fit_arr = []
		@target_dna.each_with_index { |e, i| fit_arr.push((@dna[i] - e).abs) }
		p fit_arr
		return fit_arr.inject(:+)
	end

	#Create a random starting chromosome length = to target and values randomly taken from the dna_decoder
	def rand_start
		@dna = [0]*@target.length
		@dna.map! { |i| @@dna_decoder.keys.sample }
	end

	#mutate one random spot by changing it to a new random value if it mutates
	def mutate
		@dna[((0...@dna.length).to_a).sample] = @@dna_decoder.keys.sample if Random.rand < @mutation_rate
	end

end
# class Population(target)
# 	@@create a hash of letters A..Z + " " => 0..27
# 	-gen_size
# 	-target = target.split"".map
# 	-gen[]
# 	--next_gen[]
require_relative 'organism'

class Population
	attr_accessor :gen, :target, :next_gen
	def initialize(pop_size, target="HELLO WORLD")
		@target = target
		@gen = []
		@next_gen = []
		generate_initial pop_size
		@solution = start
		puts "solution! #{@solution.decode} " if @solution != 0
	end

	def start
		r = calculate_fitness
		return r if r != 0
		for i in (0..500)
			generate_next
			r = calculate_fitness
			return r if r != 0
			min = 100000
			@gen.each { |o| max = o.fitness if o.fitness < min }
			#puts "Fitness: #{min}"
		end
		return 0
	end

	#private

	def generate_initial pop_size
		for i in 0..pop_size
			@gen << Organism.new(@target)
		end
	end

	def calculate_fitness
		@gen.each { |e| return e if e.update == "done" }
		total_fit = @gen.inject(0.0) { |sum, o| sum + o.fitness }
		@gen.each { |o| o.normalized_fit = o.fitness.to_f / total_fit.to_f }
		@gen.inject(0.0){ |sum, o| o.normalized_fit += sum }
		return 0
	end

	def select
		@gen.find{|e| e.normalized_fit >= Random.rand}
	end


	def generate_next
		@next_gen = []
		@gen.each { |e| @next_gen << combine(select, select) }
		@gen = @next_gen
	end

	def combine a, b
		r = Random.rand(0...a.dna.length)
		return Organism.new(@target, (a.dna[0...r].concat b.dna[r...b.dna.length]))
	end

end
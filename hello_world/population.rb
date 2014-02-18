require_relative 'organism'

# class Population(target)
#   @@create a hash of letters A..Z + " " => 0..27
#   -gen_size
#   -target = target.split"".map
#   -gen[]
#   --next_gen[]
class Population
  attr_accessor :gen, :target, :next_gen, :gen_number
  def initialize(pop_size, target = 'HELLO WORLD')
    @target = target
    @gen = []
    @next_gen = []
    @gen_number = 0
    generate_initial pop_size
  end

  def start
    r = calculate_fitness
    return r if r != 0
    (0..1500).each do |i|
      @gen_number = i
      generate_next
      r = calculate_fitness
      return r if r != 0
    end
    0
  end

  # private

  def generate_initial(pop_size)
    (0..pop_size).each do |i|
      @gen << Organism.new(@target)
    end
  end

  def calculate_fitness
    @gen.each { |e| return e if e.update == 'done' }
    total_fit = @gen.reduce(0.0) { |a, e| a + e.fitness }
    @gen.each { |o| o.normalized_fit = o.fitness.to_f / total_fit.to_f }
    @gen.reduce(0.0) { |a, e| e.normalized_fit += a }
    0
  end

  def select
    @gen.find { |e| e.normalized_fit >= Random.rand }
  end

  def generate_next
    @next_gen = []
    max = 0
    @gen.each { |o| max = o.fitness if o.fitness > max }
    @gen.each { |e| @next_gen << new_organism }
    @next_gen[0] = @gen.find { |o|  o.fitness >= max }
    @gen = @next_gen
  end

  def new_organism
    if Random.rand > 0.10
      combine(select, select)
    else
      select
    end
  end

  def combine(a, b)
    r = Random.rand(1..a.dna.length)
    Organism.new(@target, (a.dna[0...r].concat b.dna[r...b.dna.length]))
  end
end

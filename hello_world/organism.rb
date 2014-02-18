# class Organism(target, chromosome)
#   self.create a hash of letters A..Z + " " => 0..27
#   -chromosome #array consisting of target.length #'s 0..27
#   -fitness #how close the organism is to the goal
#   *calculate_fitness # the sum of the abs of the difference of
#    each element of the target array and the chromosome array
#   *random_starting_chromosome
#   *mutate
class Organism
  attr_accessor :dna, :fitness, :normalized_fit, :target

  def initialize(target, dna = nil, mutation_rate = 0.16)
    create_hashes
    @target = target
    @target_dna = @target.split('').map! { |e| @@dna_encoder[e] }
    @dna = dna
    @fitness = nil
    @normalized_fit = nil
    @mutation_rate = mutation_rate
    rand_start unless @dna
  end

  def update
    mutate if Random.rand < @mutation_rate
    @fitness = calculate_fitness
  end

  # decode dna
  def decode
    @dna.map { |e| @@dna_decoder[e] }.join
  end

  # Calculate the fitness by getting the sum if
  # the difference of each element of the chromosome and target array
  def calculate_fitness
    return 'done' if @dna == @target_dna
    fit_arr = []
    @target_dna.each_with_index do |e, i|
      fit_arr.push((@dna[i] - e).abs)
    end
    (1 / fit_arr.inject(:+).to_f) * 100
  end

  private

  def create_hashes
    alpha = ('A'..'Z').to_a << ' '
    indexes = (0..26).to_a
    @@dna_encoder = Hash[alpha.zip indexes]
    @@dna_decoder = Hash[indexes.zip alpha]
  end
  # Create a random starting chromosome length = to
  # target and values randomly taken from the dna_decoder
  def rand_start
    @dna = [0] * @target.length
    @dna.map! { |i| @@dna_decoder.keys.sample }
  end

  # mutate one random spot by changing it to a new random value
  def mutate
    @dna[((0...@dna.length).to_a).sample] = @@dna_decoder.keys.sample
  end
end

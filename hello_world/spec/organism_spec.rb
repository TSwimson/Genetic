require_relative "spec_helper.rb"

describe Organism do
  before :each do
    @target = "HELLO"
    @o = Organism.new @target
  end

  describe '#new' do

    it "Creates an Organism with a random starting dna when none is given" do
      @o.dna .should_not == Organism.new(@target).dna
    end
    it "Creates an Organism that with dna that matches the input" do
      dna = [2,14,21,7,12]
      Organism.new(@target, dna).dna.should == dna
    end

    it "has a target = to the set target" do
      @o.target.should == @target
    end
  end

  describe '#rand_start' do
    it "has a random start function which seeds dna randomly" do
      @o.dna.should_not == @o.rand_start
    end
end

describe '#mutate' do
    it "has a mutate function which will replace a given dna point with a new random one" do
      @o.dna.should_not == @o.mutate || @o.dna.should_not == @o.mutate
    end

    it "" do
    end
  end
    describe '#calculate_fitness' do
      it "has a calculate_fitness function that returns something" do
        @o.calculate_fitness.should_not == nil
    end
  end
end
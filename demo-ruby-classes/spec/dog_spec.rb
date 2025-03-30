require_relative '../class/dog'
require_relative 'animal_spec_helper'

RSpec.describe Dog do
  include_context 'animal noises'
  
  let(:dog) { described_class.new }
  let(:cat_food) { CatFood.new }
  let(:dog_food) { DogFood.new }
  let(:human_food) { HumanFood.new }
  let(:lemon) { Lemon.new }

  describe '#eat' do
    context 'foods the dog likes' do
      shared_examples 'barks three times' do |food_name|
        it "barks three times for #{food_name}" do
          expect { dog.eat(send(food_name)) }.to output(bark(3)).to_stdout
        end
      end

      it_behaves_like 'barks three times', :dog_food
      it_behaves_like 'barks three times', :cat_food
      it_behaves_like 'barks three times', :human_food
    end

    context 'foods the dog dislikes' do
        shared_examples 'barks one time' do |food_name|
            it "barks one time for #{food_name}" do
              expect { dog.eat(send(food_name)) }.to output(bark).to_stdout
            end
        end

        it_behaves_like 'barks one time', :lemon
    end
  end

  describe '#bark' do
    it 'barks once' do
      expect { dog.bark }.to output(bark).to_stdout
    end
  end
end 
require_relative '../class/cat'
require_relative 'animal_spec_helper'

RSpec.describe Cat do
  include_context 'animal noises'
  
  let(:cat) { described_class.new }
  let(:cat_food) { CatFood.new }
  let(:chicken) { Chicken.new }
  let(:lemon) { Lemon.new }
  let(:milk) { Milk.new }

  describe '#eat' do
    context 'foods the cat likes' do
      shared_examples 'meows three times' do |food_name|
        it "meows three times for #{food_name}" do
          expect { cat.eat(send(food_name)) }.to output(meow(3)).to_stdout
        end
      end

      it_behaves_like 'meows three times', :cat_food
      it_behaves_like 'meows three times', :chicken
      it_behaves_like 'meows three times', :milk
    end

    context 'foods the cat dislikes' do
        shared_examples 'meows one time' do |food_name|
            it "meows one time for #{food_name}" do
              expect { cat.eat(send(food_name)) }.to output(meow).to_stdout
            end
          end

          it_behaves_like 'meows one time', :lemon
    end
  end

  describe '#meow' do
    it 'meows once' do
      expect { cat.meow }.to output(meow).to_stdout
    end
  end
end 
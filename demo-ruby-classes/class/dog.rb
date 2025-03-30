require_relative 'animal'
require_relative 'food'

class Dog < Animal
  LIKED_FOODS = [DogFood, CatFood, Chicken, HumanFood].freeze

  def bark
    make_noise
  end

  private

  def make_noise
    puts "bark"
  end
end 
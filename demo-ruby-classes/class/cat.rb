require_relative 'animal'
require_relative 'food'

class Cat < Animal
  LIKED_FOODS = [CatFood, Chicken, Milk].freeze

  def meow
    make_noise
  end

  private

  def make_noise
    puts "meow"
  end
end 
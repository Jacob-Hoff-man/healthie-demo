require_relative 'class/cat'
require_relative 'class/dog'

cat = Cat.new
dog = Dog.new

cat_food = CatFood.new
dog_food = DogFood.new
human_food = HumanFood.new
chicken = Chicken.new
lemon = Lemon.new
milk = Milk.new

puts "Cat + CatFood:"
cat.eat(cat_food)
puts "\nCat + Chicken:"
cat.eat(chicken)
puts "\nCat + Milk:"
cat.eat(milk)

puts "Cat + Lemon:"
cat.eat(lemon)

puts "Dog + DogFood:"
dog.eat(dog_food)
puts "\nDog + CatFood:"
dog.eat(cat_food)
puts "\nDog + HumanFood:"
dog.eat(human_food)

puts "Dog + Lemon:"
dog.eat(lemon)
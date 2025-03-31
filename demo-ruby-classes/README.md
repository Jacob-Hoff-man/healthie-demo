# Demo - Ruby Classes

### Problem Description

Create classes Cat, Dog, Chicken, CatFood, DogFood, HumanFood, Lemon, Milk
- a cat likes CatFood, Chicken, and Milk
- a dog likes DogFood, CatFood, Chicken, HumanFood
- a Cat can meow and a Dog can bark (print "meow" or "bark" to STDOUT)
- when an animal eats food it likes, it makes a noise three times
- when an animal eats food it dislikes, it makes a noise one time
You can implement this any way you like, with whatever api you think makes sense.
Include a driver file which requires the files, instantiates the classes, and invokes the methods to
demonstrate the functionality.

### Problem Solution

- Polymorphism is used to implement specific `Animal` classes.
- A base animal class is created in `/demo-ruby-classes/class/animal.rb` that defines a common interface for animals to use:
    - `eat` method to determine the noise count for the output.
    - `make_noise` method that must be overwritten to implement their particular noise.
    - `likes?` method to check if the animal likes a particular food class.
- Specific animal classes (e.g. `Dog` and `Cat`) inherit from the `Animal` class, and require a `LIKED_FOODS` constant array and a `make_noise` method to be defined.
- This implementation allows for different specific Animal classes to all use the same `eat` method with different implementations.

### How To Run

- In a terminal, traverse to the `demo-ruby-classes` directory
    - Run `bundle install` to install dependencies.
    - Run `ruby main.rb` to run the main file.
    - Run `rspec` to run the tests defined in `demo-ruby-classes/spec`.


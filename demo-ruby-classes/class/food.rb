class Food
  def name
    self.class.name
  end
end

class CatFood < Food; end
class DogFood < Food; end
class HumanFood < Food; end
class Chicken < Food; end
class Lemon < Food; end
class Milk < Food; end 
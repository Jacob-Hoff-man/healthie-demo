class Animal
  def eat(food)
    times = likes?(food) ? 3 : 1
    times.times { make_noise }
  end

  private

  def likes?(food)
    self.class::LIKED_FOODS.include?(food.class)
  end

  def make_noise
    raise NotImplementedError, "#{self.class} must implement make_noise"
  end
end 
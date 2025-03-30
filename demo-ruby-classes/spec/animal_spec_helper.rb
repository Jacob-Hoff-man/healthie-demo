RSpec.shared_context 'animal noises' do
  def repeated_noise(noise, times = 1)
    ([noise] * times).join("\n") + "\n"
  end

  def meow(times = 1)
    repeated_noise('meow', times)
  end

  def bark(times = 1)
    repeated_noise('bark', times)
  end
end 
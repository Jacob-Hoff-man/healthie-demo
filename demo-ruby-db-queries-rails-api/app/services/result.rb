class Result
  attr_reader :success, :data, :errors

  def initialize(success:, data: nil, errors: [])
    @success = success
    @data = data
    @errors = errors
  end

  def self.success(data)
    new(success: true, data: data)
  end

  def self.error(errors)
    new(success: false, errors: Array(errors))
  end

  def success?
    @success
  end
end 
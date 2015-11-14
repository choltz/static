Namespace.build('Services::Compose') do
  include Services::Base

  attr_accessor :services

  # Public: Constructor - collect the services to be used in the composition.
  #
  # services - comma-delimited list of services
  def initialize(*services)
    @services = services
  end

  # Public: Compose multiple services into a chain of calls, each returning an
  # updated options hash.
  #
  # options - parameter hash
  #
  # Returns: updated parameter hash
  def call(options = {})
    self.services.inject(options) do |results, service|
      service.call results
    end
  end

  # Public: override | operator to use as short-hand to compose multiple
  # services
  def |(value)
    @services << value
    self
  end
end

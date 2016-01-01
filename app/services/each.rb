Namespace.build('Services::Each') do
  include Services::Base

  # Public: collect an enumerator and a service to process
  #
  # enumerator - any enumerable list
  # service    - service object to apply to each item in the enumerator
  def initialize(enumerator, service)
    @enumerator = enumerator
    @service    = service
  end

  # Public: Enumerate through each item in the enumerator, apply that
  # the item to the service provided.
  #
  # options - parameter hash
  #
  # Returns: parameter hash
  def call(options = {})
    @enumerator.each do |item|
      options[:item] = item
      options = @service.call(options)
    end
    options
  end
end

require_relative '../test_helper'

# Tests for Services::Base
Namespace.build('Services::BaseTest', Minitest::Test) do
  context 'service base test' do
    should 'forward the class-level call method to an instace' do
      results = BaseServiceTest.call
      assert_equal true, results[:called]
    end
  end

  private

  # Internal: test class to verify Services::Base behavior
  class BaseServiceTest
    include Services::Base

    def call(options = {})
      options[:called] = true
      options
    end
  end
end

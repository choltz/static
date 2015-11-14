require_relative '../test_helper'
require_relative '../../app/services/compose'

# Tests for Services::Compose
Namespace.build('Services::ComposeTest', Minitest::Test) do
  context 'service compose test' do
    should 'store the services being composed' do
      composition = Services::Compose.new AddOne, Square

      assert_equal composition.services, [AddOne, Square]
    end

    should 'compose a new service based on multiple services' do
      add_one_and_square = Services::Compose.new AddOne, Square

      assert_equal 9,  add_one_and_square.call(value: 2)[:value]
      assert_equal 16, add_one_and_square.call(value: 3)[:value]
      assert_equal 25, add_one_and_square.call(value: 4)[:value]
    end

    should 'support short-hand syntax for service composition' do
      add_one_and_square = AddOne | Square

      assert_equal 9,  add_one_and_square.call(value: 2)[:value]
      assert_equal 16, add_one_and_square.call(value: 3)[:value]
      assert_equal 25, add_one_and_square.call(value: 4)[:value]
    end

    should 'support muliple services in composition' do
      add_one_and_square_and_add_one_again = AddOne | Square | AddOne

      assert_equal 10, add_one_and_square_and_add_one_again.call(value: 2)[:value]
      assert_equal 17, add_one_and_square_and_add_one_again.call(value: 3)[:value]
      assert_equal 26, add_one_and_square_and_add_one_again.call(value: 4)[:value]
    end

  end

  private

  # Internal: Add one to the value given
  class AddOne
    include Services::Base

    def call(options = {})
      options.tap do |opts|
        opts[:value] = opts[:value] + 1
      end
    end
  end

  # Internal: Square the value given
  class Square
    include Services::Base

    def call(options = {})
      options.tap do |opts|
        opts[:value] = opts[:value] ** 2
      end
    end
  end
end

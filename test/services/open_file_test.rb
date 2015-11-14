require_relative '../test_helper'

# Tests for Services::Base
Namespace.build('Services::OpenFileTest', Minitest::Test) do
  context 'open file service tests' do
    should 'Given a file path, open and save the contents' do
      options = { file: 'test/data/post1.markdown' }
      results = Services::Posts::OpenFile.call(options)

      assert_equal 'test/data/post1.markdown', results[:file]
      assert_equal true, results.key?(:contents)
    end
  end
end

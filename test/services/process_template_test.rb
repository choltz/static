require_relative '../test_helper'

# Tests for Services::Base
Namespace.build('Services::Site::ProcessTemlateTest', Minitest::Test) do
  context 'process template service tests' do
    should 'initialize with the template name' do
      service = Services::Site::ProcessTemplate.new(:template_name)

      assert_equal :template_name, service.template
    end

    should 'process the specified template into html' do
      service = Services::Site::ProcessTemplate.new(:test_template, 'test/data')
      results = service.call(text: 'testing')

      assert_equal "<h1>\n  testing\n</h1>", results[:test_template]
    end
  end
end

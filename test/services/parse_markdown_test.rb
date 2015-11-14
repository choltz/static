require_relative '../test_helper'

# Tests for Services::Base
Namespace.build('Services::ParseMarkdownTest', Minitest::Test) do
  context 'open file service tests' do
    should 'Given a block of markdown with a properties header, convert the markdown to html' do
      contents =  File.open('test/data/post1.markdown') { |file| file.read }
      results  = Services::Posts::ParseMarkdown.call( contents: contents)
      expected = "<p><em>This</em> is a markdown file</p>\n"

      assert_equal expected, results[:html]
    end

    should 'parse out the properties properly when the markdown contains the triple hyphen outside the properties block' do
      contents =  File.open('test/data/post3.markdown') { |file| file.read }
      results  = Services::Posts::ParseMarkdown.call( contents: contents)
      expected = "<p><em>This</em> is a markdown file.</p>\n\n<p>There is a --- triple hyphen here.</p>\n"

      assert_equal expected, results[:html]
    end
  end
end

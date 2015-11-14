require_relative '../test_helper'

Namespace.build('Services::ParsePropertiesTest', Minitest::Test) do
  context 'parse properties service tests' do
    should 'Given a block of markup with a properties header, extract the properties into a hash' do
      contents =  File.open('test/data/post1.markdown') { |file| file.read }
      results  = Services::Posts::ParseProperties.call( contents: contents )
      expected = {'layout'=>'post', 'title'=>'test post 1', 'date'=>'2013-07-30 14:13', 'comments'=>'true', 'thumbnail'=>'/images/test_post_1.png', 'categories'=>''}

      assert_equal expected, results[:properties]
    end

    should 'parse out the properties properly when the markdown contains the triple hyphen outside the properties block' do
      contents =  File.open('test/data/post3.markdown') { |file| file.read }
      results  = Services::Posts::ParseProperties.call( contents: contents )
      expected = {'layout'=>'post', 'title'=>'test post 3', 'date'=>'2013-07-31 14:13', 'comments'=>'true', 'thumbnail'=>'/images/test_post_3.png', 'categories'=>""}

      assert_equal expected, results[:properties]
    end
  end
end

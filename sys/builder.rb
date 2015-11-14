Bundler.require(:default)
require_relative '../config/slim'

class Builder
  class << self
    # Convert the slim files in the source folder into html in the site folder
    def build
      posts = Dir['app/posts/*']
      posts = posts.map{ |post| parse_post_properties(post) }
                   .map{ |post| parse_markdown(post) }

      site_files = Dir['app/views/*']
      site_files.map  { |path| generate_site_files(path, posts) }
                .each { |path, content| write_files(path, content) }
    end

    # Public: Given a post data object, convert the markdown property into
    # html.
    #
    # post - post data object that contains a markdown property
    #
    # Returns - post data object with body property
    def parse_markdown(post)
      renderer = Redcarpet::Render::HTML.new
      parser = Redcarpet::Markdown.new renderer

      post.body = parser.render(post.markdown)
      post
    end

    # Public: Given a post file path, read the file and strip embedded data from
    # the top of the markdown and convert it into a post data object. Load the
    # data object with the embedded data markdown from the file.
    #
    # path - path to the post markdown file
    #
    # Returns: post data object
    def parse_post_properties(path)
      content       = File.open(path).read
      properties    = content.split(/---\n/)[1]                                  # extract properties block
                             .split(/\n/)                                        # split the properties by line
                             .map{ |p| p.match(/(^[^:]+):([^$]*)/) }             # split each line by key and value
                             .map{ |p| [p[1], p[2].strip.gsub(/^\"|\"$/, '') ] } # strip extra quotes and space out of each value
                             .flatten
      data          = OpenStruct.new Hash[*properties]
      data.markdown = content.split(/---\n/)[2]
      data
    end

    # Public: Transform the given slim path to html and include the path with
    # an HTML extension
    def generate_site_files(path, posts)
      slim = Slim::Template.new(path).render(Object.new, content: 'this is the content')

      [path.split('/').pop.gsub(/\.slim/, '.html'), slim]
    end

    # Write the given content to the path specified
    def write_files(path, content)
      File.open("site/#{path}", 'w') { |file| file.write content }
      puts "re-built site/#{path}"
    end
  end
end

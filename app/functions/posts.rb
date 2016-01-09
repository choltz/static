class Posts
  include Methodology

  function(:open_file) do |file|
    File.open(file).read
  end

  function(:parse_properties) do |contents|
    results = contents.split(/---\n/)[1] # extract properties block
                      .split(/\n/)       # split the properties by line
                      .map(&method(:split_by_key_and_value))
                      .map(&method(:strip_quotes_and_space))
                      .flatten

    Hash[*results]
  end

  function(:parse_markdown) do |contents|
    renderer = Redcarpet::Render::HTML.new
    parser   = Redcarpet::Markdown.new renderer
    markdown = contents.gsub(/---.+?---/m, '')
    parser.render markdown
  end

  private

  # Internal: split a string whose key and value are separated by a colon
  #
  # text - string to parse
  #
  # Notes: it would be much easier to simply split(':'), but this does not
  # play nice with dates that contain times with colon delimiters
  #
  # Returns: a regex match
  def self.split_by_key_and_value(text)
    text.match(/(^[^:]+):([^$]*)/)
  end

  # Internal: Given a regex match with a key and value, return an array of the
  # first match and the last match with leading/trailing spaces and quotes
  # removed
  #
  # match - regex match object that contains the key and value from a string
  #
  # Returns: Array of key and value with spaces and quotes stripped
  def self.strip_quotes_and_space(match)
    [match[1], match[2].strip.gsub(/^\"|\"$/, '')]
  end
end

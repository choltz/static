Namespace.build('Services::Site::GenerateStructure') do
  include Services::Base

  # Public: Given a list of site files, process them through slim to get html
  # output
  #
  # options - parameter hash
  #
  # Returns: unmodified parameter hash
  def call(options = {})
    options.tap do |opts|
      sidebar = Slim::Template.new('app/views/sidebar.slim').render(Object.new, posts: options[:posts])

      #opts[:site_files].each do |site_file|
      #  slim = Slim::Template.new(site_file).render(Object.new) #, content: 'this is the content')
      #  # [path.split('/').pop.gsub(/\.slim/, '.html'), slim]
      #end


    end
  end
end

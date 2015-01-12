namespace :doc do
  desc 'Generate RDoc documentation'
  task :generate do
    #Remove directory if exists (Sooooo much faster rdoc time.)
    system('rm -rf doc/') if File.exists?('doc/index.html')

    #Generate the RDoc
    system('rdoc')

    #point browser at doc/index.html
    system("open", "doc/index.html")
  end
end

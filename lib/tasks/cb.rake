namespace :cb do
  desc "Run all tests for this project"
  task :test do
    exit_codes = []
    exit_codes << system('bundle exec rspec')
    exit (exit_codes.include?(false) ? 1 : 0)
  end
end

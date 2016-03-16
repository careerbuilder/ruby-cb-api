# Copyright 2016 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
# Load all custom tasks
Dir.glob(File.join('lib', 'tasks', '*.rake')).each { |r| load r }

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--color -fd'
  t.pattern = 'spec/**/*_spec.rb'
end

RSpec::Core::RakeTask.new(:smoke) do |t|
  t.pattern = 'specsmoke/**/*_spec.rb'
end

desc 'Run all specs then immediately open the coverage report'
task :coverage do
  begin
    Rake::Task[:spec].execute
  rescue Exception
    # eat the 'exception' that is the non-zero exit code caused by failing tests
  end
  `open coverage/index.html` if RUBY_PLATFORM.downcase.include?('darwin')
  `start coverage/index.html` if RUBY_PLATFORM.downcase.include?('mswin')
end

desc 'Run Tests'
task default: :spec

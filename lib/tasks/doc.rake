# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
namespace :doc do
  desc 'Generate RDoc documentation'
  task :generate do
    # Remove directory if exists (Sooooo much faster rdoc time.)
    system('rm -rf doc/') if File.exist?('doc/index.html')

    # Generate the RDoc
    system('rdoc')

    # point browser at doc/index.html
    system('open', 'doc/index.html')
  end
end

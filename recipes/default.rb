#
# Cookbook Name:: glances
# Recipe:: default
#
# Copyright 2011, Heavy Water Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "build-essential"
package "pkg-config"
package "python"
package "python-dev"
package "libstatgrab-dev"

remote_file "/usr/src/#{node[:pystatgrab][:source]}" do
  source node[:pystatgrab][:uri]
  action :create_if_missing
end

execute "pystatgrab: untar #{node[:pystatgrab][:source]}" do
  command "tar zxf #{node[:pystatgrab][:source]}"
  creates "/usr/src/#{node[:pystatgrab][:dir]}"
  cwd "/usr/src"
end

execute "pystatgrab: build" do
  command "./setup.py build"
  creates "/usr/local/lib/python2.7/dist-packages/statgrab.py"
  cwd "/usr/src/#{node[:pystatgrab][:dir]}"
end

execute "pystatgrab: install" do
  command "sudo ./setup.py install"
  creates "/usr/local/lib/python2.7/dist-packages/statgrab.py"
  cwd "/usr/src/#{node[:pystatgrab][:dir]}"
end

remote_file "/usr/src/#{node[:glances][:source]}" do
  source node[:glances][:uri]
  action :create_if_missing
end

execute "glances: untar #{node[:glances][:source]}" do
  command "tar zxf #{node[:glances][:source]}"
  creates "/usr/src/#{node[:glances][:dir]}"
  cwd "/usr/src"
end

execute "glances: build" do
  command "./configure; make;"
  creates "/usr/local/bin/glances.py"
  cwd "/usr/src/#{node[:glances][:dir]}"
end

execute "glances: install" do
  command "sudo make install"
  creates "/usr/local/bin/glances.py"
  cwd "/usr/src/#{node[:glances][:dir]}"
end

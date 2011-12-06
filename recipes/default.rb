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
package "build-essential" do
  action :install
end

package "git-core" do
  action :install
end

package "pkg-config" do
  action :install
end

package "python" do
  action :install
end

package "python-dev" do
  action :install
end

package "libstatgrab-dev" do
  action :install
end

remote_file "/tmp/#{node.pystatgrab.source}" do
  source node.pystatgrab.uri
  mode "0644"
  not_if do
    File.exists?("/tmp/#{node.pystatgrab.source}")
  end
end

execute "Exploding pystatgrab archive #{node.pystatgrab.source}" do
  command "cd /tmp; tar zxvf #{node.pystatgrab.source}"
  not_if "test -d /tmp/#{node.pystatgrab.dir}"
end

execute "Build pystatgrab" do
  command "cd /tmp/#{node.pystatgrab.dir}; ./setup.py build"
  not_if "test -f /tmp/#{node.pystatgrab.dir}/statgrab.py"
end

execute "Install pystatgrab" do
  command "cd /tmp/#{node.pystatgrab.dir}; sudo ./setup.py install"
end

remote_file "/tmp/#{node.glances.source}" do
  source node.glances.uri
  mode "0644"
  not_if do
    File.exists?("/tmp/#{node.glances.source}")
  end
end

execute "Exploding glances archive #{node.glances.source}" do
  command "cd /tmp; tar zxvf #{node.glances.source}"
  not_if "test -d /tmp/#{node.glances.dir}"
end

execute "Build glances" do
  command "cd /tmp/#{node.glances.dir}; ./configure; make"
end

execute "Install glances" do
  command "cd /tmp/#{node.glances.dir}; sudo make install"
end

execute "Check for clean up signal to destroy" do
  command "cd /tmp; sudo rm -rf glances*; sudo rm -rf pystatgrab*"
  only_if { node[:destroy] }
end


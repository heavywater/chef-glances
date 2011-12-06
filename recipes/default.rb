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

remote_file "/tmp/#{node.pystatgrab.source}" do
  source node.pystatgrab.uri
  mode "0644"
  not_if do
    File.exists?("/tmp/#{node.pystatgrab.source}")
  end
end

execute "Exploding pystatgrab archive #{node.pystatgrab.source}" do
  command "tar zxf #{node.pystatgrab.source}"
  creates "/tmp/#{node.pystatgrab.dir}"
  cwd "/tmp"
  not_if "test -d /tmp/#{node.pystatgrab.dir}"
end

execute "Install pystatgrab" do
  command "./setup.py build; sudo ./setup.py install"
  cwd "/tmp/#{node.pystatgrab.dir}"
  not_if "test -f /tmp/#{node.pystatgrab.dir}/statgrab.py"
end

remote_file "/tmp/#{node.glances.source}" do
  source node.glances.uri
  mode "0644"
  not_if do
    File.exists?("/tmp/#{node.glances.source}")
  end
end

execute "Exploding glances archive #{node.glances.source}" do
  command "tar zxf #{node.glances.source}"
  creates "/tmp/#{node.glances.dir}"
  cwd "/tmp"
  not_if "test -d /tmp/#{node.glances.dir}"
end

execute "Install glances" do
  command "./configure; make; sudo make install"
  cwd "/tmp/#{node.glances.dir}"
end

execute "Cleaning up" do
  command "cd /tmp; sudo rm -rf glances*; sudo rm -rf pystatgrab*"
end


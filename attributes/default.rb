## Cookbook Name:: glances
## Attributes:: default
##
## Copyright 2011, Heavy Water Software Inc.
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##

default[:pystatgrab][:source] = "pystatgrab-0.5.tar.gz"
default[:pystatgrab][:dir] = "pystatgrab-0.5"
default[:pystatgrab][:uri] = "http://ftp.uk.i-scream.org/sites/ftp.i-scream.org/pub/i-scream/pystatgrab/pystatgrab-0.5.tar.gz"

default[:glances][:source] = "glances-1.1.3.tar.gz"
default[:glances][:dir] = "glances-1.1.3"
default[:glances][:uri] = "https://github.com/downloads/nicolargo/glances/glances-1.1.3.tar.gz"


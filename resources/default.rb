# Encoding: utf-8
# Author:: Sandeep Bhat (<sandeep.s.bhat@nordstrom.com>) with

# Cookbook Name:: win_shadowcopy
# Provider:: shadowcopy
#
# Copyright:: 2015, Nordstrom, Inc.
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

actions :enable, :schedule
default_action :enable

attribute :shadowcopy_drivepath, kind_of: String
attribute :shadowcopy_maxsize, kind_of: String
attribute :shadowcopy_storagepath, kind_of: String

attribute :schedule_drivepath, kind_of: String
attribute :schedule_time, kind_of: String
attribute :schedule_ensure, kind_of: String
attribute :schedule_taskname, kind_of: String

attr_accessor :exists
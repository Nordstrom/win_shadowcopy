# Encoding: utf-8
# Author:: Sandeep Bhat (<sandeep.s.bhat@nordstrom.com>)
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

include Chef::Mixin::ShellOut
include Windows::Helper
include Windows::Shadowcopy

# Support whyrun
def whyrun_supported?
  true
end

use_inline_resources

action :config do
  if @current_resource.exists
    Chef::Log.info 'Already set - nothing to do.'
  else
    converge_by("Create #{@new_resource}") do
      enable_shadowcopy
      schedule_shadowcopy
      new_resource.updated_by_last_action true
    end
  end
end

# rubocop:disable AbcSize
def load_current_resource
  @current_resource = Chef::Resource::WseUtilShadowcopy.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  @current_resource.shadowcopy_drivepath(@new_resource.shadowcopy_drivepath)
  @current_resource.shadowcopy_maxsize(@new_resource.shadowcopy_maxsize)
  @current_resource.shadowcopy_storagepath(@new_resource.shadowcopy_storagepath)
  @current_resource.schedule_ensure(@new_resource.schedule_ensure)
  @current_resource.schedule_drivepath(@new_resource.schedule_drivepath)
  @current_resource.schedule_time(@new_resource.schedule_time)
  @current_resource.schedule_taskname(@new_resource.schedule_taskname)
  @current_resource.exists = config_exists?(@current_resource.name)
end
# rubocop:enable AbcSize

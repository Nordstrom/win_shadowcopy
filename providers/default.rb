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

# Support whyrun
def whyrun_supported?
  true
end

use_inline_resources

action :enable do
  if @current_resource.exists
    Chef::Log.info 'Already set - nothing to do.'
  else
    converge_by("Create #{@new_resource}") do
      enable_shadowcopy
      new_resource.updated_by_last_action true
    end
  end
end

action :schedule do
  if @current_resource.exists
    Chef::Log.info 'Already set - nothing to do.'
  else
    converge_by("Create #{@new_resource}") do
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
end
# rubocop:enable AbcSize

# rubocop:disable MethodLength
def enable_shadowcopy
  shadowcopy_drivepath = new_resource.shadowcopy_drivepath
  shadowcopy_storagepath = new_resource.shadowcopy_storagepath
  shadowcopy_maxsize = new_resource.shadowcopy_maxsize
  dsc_script 'enable_shadowcopy' do
    code <<-EOH
    cVSS SetShadowCopy{
        Drive = '#{shadowcopy_drivepath}'
        Enable = $True
        StorageLocation = '#{shadowcopy_storagepath}'
        MaxSize = '#{shadowcopy_maxsize}'
     }
     EOH
  end
end

def schedule_shadowcopy
  schedule_drivepath = new_resource.schedule_drivepath
  schedule_time = new_resource.schedule_time
  schedule_ensure = new_resource.schedule_ensure
  schedule_taskname = new_resource.schedule_taskname
  dsc_script 'schedule_shadowcopy' do
    code <<-EOH
      cVSSTaskScheduler ScheduleCopy{
          TaskName = '#{schedule_taskname}'
          Ensure =  '#{schedule_ensure}'
          Drive = '#{schedule_drivepath}'
          TriggerTime = '#{schedule_time}'
      }
     EOH
  end
end
# rubocop:enable MethodLength
